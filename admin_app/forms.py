from django import forms
from .models import Project, Task, Taskprogress, user, Sprint



# Form for user model
class UserForm(forms.ModelForm):
    class Meta:
        model = user
        fields = ['reg_no', 'name', 'designation', 'image', 'phone', 'email','password']
        widgets = {
            'reg_no': forms.TextInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'designation': forms.TextInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'image': forms.ClearableFileInput(attrs={'class': 'form-control-file'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control'})
        }

# Form for Project model
class ProjectForm(forms.ModelForm):
    no_deadline = forms.BooleanField(required=False, label="No Deadline for this project", initial=False)

    assigned = forms.ModelMultipleChoiceField(
        queryset=user.objects.all(),
        widget=forms.CheckboxSelectMultiple,  # This will render a list of checkboxes
        label="Assigned Members"
    )

    class Meta:
        model = Project
        fields = ['name','short_code', 'client','description','category', 'files', 'assigned','budget', 'start_date', 'due_date', 'progress','category','status','priority']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'short_code': forms.TextInput(attrs={'class': 'form-control'}),
            'client': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control'}),
            'start_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'due_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'progress': forms.NumberInput(attrs={'class': 'form-control', 'min': 0, 'max': 100}),
            'category': forms.Select(attrs={'class': 'form-select'}),
            'assigned': forms.Select(attrs={'class': 'form-select'}),
            'status': forms.Select(attrs={'class':'form-select'}),
            'priority': forms.Select(attrs={'class': 'form-select'}),
            'budget': forms.TextInput(attrs={'class': 'form-control'}),


        }

        def clean_due_date(self):
            if self.cleaned_data.get('no_deadline'):
                return None  # If 'No Deadline' is selected, set due_date to None
            return self.cleaned_data.get('due_date')


class SprintForm(forms.ModelForm):
    class Meta:
        model = Sprint
        fields = ['sprint_name', 'start_date', 'end_date','description']

    widgets = {

        'start_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
        'end_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
        'estimated_hours': forms.NumberInput(attrs={'class': 'form-control'}),
    }



class TaskForm(forms.ModelForm):
    no_deadline = forms.BooleanField(required=False, label="No Deadline for this task", initial=False)
    assigned_to = forms.ModelMultipleChoiceField(
        queryset=user.objects.all(),  # Assuming User is imported
        widget=forms.CheckboxSelectMultiple,
        label="Assign to Members"
    )
    client = forms.CharField(
        label="Client",
        required=False,
        widget=forms.TextInput(attrs={'class': 'form-control'})  # Removed readonly
    )

    class Meta:
        model = Task
        fields = [
            'project', 'task_name', 'description', 'category',
            'assigned_to', 'priority', 'status', 'start_date', 'due_date',
            'estimated_hours',
        ]
        widgets = {
            'project': forms.Select(attrs={'class': 'form-control'}),
            'task_name': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'priority': forms.Select(attrs={'class': 'form-control'}),
            'status': forms.Select(attrs={'class': 'form-control'}),
            'start_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'due_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'estimated_hours': forms.NumberInput(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        super(TaskForm, self).__init__(*args, **kwargs)

        # Auto-fill client and assigned users based on selected project
        if 'project' in self.data:
            try:
                project_id = int(self.data.get('project'))
                project = Project.objects.get(id=project_id)
                self.fields['client'].initial = (
                    project.client.name if hasattr(project.client, 'name') else project.client
                )
                self.fields['assigned_to'].queryset = project.assigned.all()  # Update queryset for assigned users
            except (ValueError, Project.DoesNotExist):
                self.fields['client'].initial = "No Client"
        elif self.instance.pk and self.instance.project:
            project = self.instance.project
            self.fields['client'].initial = (
                project.client.name if hasattr(project.client, 'name') else project.client
            )
            self.fields['assigned_to'].queryset = project.assigned.all()  # Update queryset for assigned users

    def clean_client(self):
        """Ensure the client field remains unchanged."""
        if self.instance.pk and self.instance.project:
            project = self.instance.project
            return project.client.name if hasattr(project.client, 'name') else project.client
        return self.cleaned_data.get('client')
# Form for Taskprogress model
class TaskProgressForm(forms.ModelForm):
    class Meta:
        model = Taskprogress
        fields = ['task', 'user', 'start_time', 'end_time']
        widgets = {
            'start_time': forms.DateTimeInput(attrs={'class': 'form-control', 'type': 'datetime-local'}),
            'end_time': forms.DateTimeInput(attrs={'class': 'form-control', 'type': 'datetime-local'}),
        }


class UserLoginForm(forms.Form):
    reg_no = forms.CharField(max_length=50, widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))