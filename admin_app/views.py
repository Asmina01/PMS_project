import json
from datetime import date

from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.contrib.auth.hashers import check_password
from django.shortcuts import render, get_object_or_404
from django.db.models import Q

# Create your views here.


from django.shortcuts import render, redirect

from employee_app.models import Comment
from .models import Project, Task, Taskprogress, Sprint
from .forms import ProjectForm, TaskForm, UserForm, SprintForm, UserLoginForm

from django.db.models import Sum, F

from django.shortcuts import render
from django.http import JsonResponse
from .models import Project, user

def get_project_members(request):
    project_id = request.GET.get('project_id')
    assigned = []
    if project_id:
        try:
            project = Project.objects.get(id=project_id)
            assigned = project.assigned.all()
        except Project.DoesNotExist:
            pass

    return render(request, 'members_list.html', {'assigned': assigned})

def admin_assigned_projects(request):
    # Get filter parameters from the request
    status_filter = request.GET.get('status', '')
    priority_filter = request.GET.get('priority', '')
    category_filter=request.GET.get('category','')
    start_date = request.GET.get('start_date', '')
    due_date = request.GET.get('due_date', '')
    no_deadline = request.GET.get('no_deadline', '')
    client_filter = request.GET.get('client', '')

    search_query = request.GET.get('search', '')

   
    projects = Project.objects.all()

    # Applying filters 
    if status_filter:
        projects = projects.filter(status=status_filter)
    if priority_filter:
        projects = projects.filter(priority=priority_filter)
    if category_filter:
        projects=projects.filter(category=category_filter)
    if start_date:
        projects = projects.filter(start_date=start_date)
    if due_date:
        projects = projects.filter(due_date=due_date)
    if no_deadline:  # Check if "No Deadline" is selected
        projects = projects.filter(due_date__isnull=True)
    if client_filter:  # Filter by client if provided
        projects = projects.filter(client=client_filter)

    total_projects = projects.count()  # Count total number of projects

    # Apply search filter
    if search_query:
        projects = projects.filter(
            Q(name__icontains=search_query) |  # Search project name
            Q(assigned__name__icontains=search_query)  # Search assigned employee's name
        ).distinct()

    clients = Project.objects.values_list('client', flat=True).distinct()

 
    context = {
        'projects': projects,
        'total_projects': total_projects,
        'status_filter': status_filter,
        'priority_filter': priority_filter,
        'category_filter':category_filter,
        'search_query': search_query,
        'start_date': start_date,
        'due_date': due_date,
        'no_deadline': no_deadline,
        'client_filter': client_filter,
        'clients':clients
    }
    return render(request, 'admin_assigned_projects.html', context)

def assign_task(request):
    form = TaskForm()
    if request.method == "POST":
        form = TaskForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('task_list')
    return render(request, 'assign_task.html', {'form': form})


def get_client(request):
    project_id = request.GET.get('project_id')
    try:
        project = Project.objects.get(id=project_id)
        return JsonResponse({'client': project.client})
    except Project.DoesNotExist:
        return JsonResponse({'client': 'No Client'})
def create_project(request):
    if request.method == 'POST':
        form = ProjectForm(request.POST, request.FILES)
        if form.is_valid():
            form.save() 
            return redirect('admin_assigned_projects')
    else:
        form = ProjectForm()

    return render(request, 'create_project.html', {'form': form})

def view_progress(request):


    projects = Project.objects.all()
    progress_data = []

    for project in projects:
        total_tasks = project.tasks.count()
        completed_tasks = project.tasks.filter(status='Completed').count()
        progress_percentage = (completed_tasks / total_tasks) * 100 if total_tasks > 0 else 0
        progress_data.append({'project': project, 'progress': progress_percentage})

    context = {'progress_data': progress_data}
    return render(request, 'view_progress.html', context)



def view_time_tracking(request):


    time_logs = Taskprogress.objects.values('task__name', 'task__project__name', 'employee__username').annotate(
        total_hours=Sum(F('end_time') - F('start_time'))
    )

    context = {'time_logs': time_logs}
    return render(request, 'view_time_tracking.html', context)


def adminindex(request):
    return render(request, 'adminindex.html')
def base(request):
    projects = Project.objects.all()
    total_projects = projects.count()
    ongoing_projects = projects.filter(progress__gt=0, progress__lt=100).count()
    completed_projects = projects.filter(progress=100).count()
    not_started_projects = projects.filter(progress=0).count()
    in_progress_projects = ongoing_projects

    context = {
        'projects': projects,
        'total_projects': total_projects,
        'ongoing_projects': ongoing_projects,
        'completed_projects': completed_projects,
        'not_started_projects': not_started_projects,
        'in_progress_projects': in_progress_projects,
    }
    return render(request, 'base.html', context)
def add_member(request):
    if request.method == 'POST':
        form = UserForm(request.POST, request.FILES)  
        if form.is_valid():
            form.save()  
            return redirect('members_list')  
        else:
            print(form.errors)  
    else:
        form = UserForm()

    return render(request, 'add_member.html', {'form': form})


def members_list(request):
    members = user.objects.all()
    return render(request, 'members_list.html', {'members': members})

def project_list(request):
    projects = Project.objects.all() 
    return render(request, 'project_list.html', {'projects': projects})


def project_overview(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    comments = Comment.objects.filter(project=project).order_by('-created_at')

    if request.method == 'POST':
        content = request.POST.get('content')
        if content:
            Comment.objects.create(user=request.user, project=project, content=content)

    return render(request, 'project_overview.html', {'project': project, 'comments': comments})


def task_list(request):
    tasks = Task.objects.all()  

    # filter
    status_filter = request.GET.get('status', '')
    category_filter = request.GET.get('category', '')
    priority_filter = request.GET.get('priority', '')
    project_filter = request.GET.get('project', '')
    assigned_to_filter = request.GET.get('assigned_to', '')
    start_date_filter = request.GET.get('start_date', '')
    due_date_filter = request.GET.get('due_date', '')
    estimated_hours_filter = request.GET.get('estimated_hours', '')
    hide_completed = request.GET.get('hide_completed', '')

    if hide_completed == 'on':  # Checkbox sends 'on' if checked
        tasks = tasks.exclude(status='Completed')

    if status_filter:
        tasks = tasks.filter(status=status_filter)
    if category_filter:
        tasks = tasks.filter(category=category_filter)
    if priority_filter:
        tasks = tasks.filter(priority=priority_filter)
    if project_filter:
        tasks = tasks.filter(project__id=project_filter)
    if assigned_to_filter:
        tasks = tasks.filter(assigned_to__id=assigned_to_filter)
    if start_date_filter:
        tasks = tasks.filter(start_date__gte=start_date_filter)
    if due_date_filter:
        tasks = tasks.filter(due_date__lte=due_date_filter)
    if estimated_hours_filter:
        tasks = tasks.filter(estimated_hours__gte=estimated_hours_filter)

    # Calculate time spent on tasks
    total_company_seconds = 0  

    for task in tasks:
        total_seconds = sum((entry.stop_time - entry.start_time).total_seconds()
                            for entry in task.task_times.all() if entry.start_time and entry.stop_time)
        task.total_hours = int(total_seconds // 3600)
        task.total_minutes = int((total_seconds % 3600) // 60)
        total_company_seconds += total_seconds 

        completed_time = task.task_times.filter(stop_time__isnull=False).order_by('-stop_time').first()
        task.completed_time_display = completed_time.stop_time if completed_time else None

    


    return render(request, 'task_list.html', {
        'tasks': tasks,
        'status_filter': status_filter,
        'category_filter': category_filter,
        'priority_filter': priority_filter,
        'project_filter': project_filter,
        'assigned_to_filter': assigned_to_filter,
        'start_date_filter': start_date_filter,
        'due_date_filter': due_date_filter,
        'estimated_hours_filter': estimated_hours_filter,
        'hide_completed': hide_completed,

    })

def delete_member(request, reg_no):
    member = get_object_or_404(user, reg_no=reg_no)  
    if request.method == 'POST':
        member.delete() 
        return redirect('members_list')


def delete_project(request, project_id):
    project = get_object_or_404(Project, pk=project_id)
    if request.method == 'POST':
        project.delete()
        return redirect('admin_assigned_projects') 
    return redirect('admin_assigned_projects') 


def progress_page(request):
    projects = Project.objects.all()
    project_data = []

    for project in projects:
        tasks = project.tasks.all()

        
        total_progress = 0
        total_tasks = tasks.count()
        pending_tasks = tasks.filter(status='Pending').count()
        in_progress_tasks = tasks.filter(status='In Progress').count()
        completed_tasks = tasks.filter(status='Completed').count()

        for task in tasks:
            if task.status == 'Completed':
                total_progress += 100
            elif task.status == 'In Progress':
                total_progress += 60  
            else:
                total_progress += 0  

        project_progress = total_progress / total_tasks if total_tasks else 0 

        project_data.append({
            'project_name': project.name,
            'project_description': project.description,
            'project_progress': project_progress,
            'total_tasks': total_tasks,
            'pending_tasks': pending_tasks,
            'in_progress_tasks': in_progress_tasks,
            'completed_tasks': completed_tasks,
            'tasks': tasks 
        })

    return render(request, 'progress_page.html', {'project_data': project_data})

def backlog_list(request):
   
    high_priority_pending_tasks = Task.objects.filter( status='Pending').order_by('-start_date')

   
    recent_tasks = Task.objects.all().order_by('-start_date')[:5]  
    backlog_tasks=Task.objects.filter(status="Backlog")

    
    return render(request, 'backlog_list.html', {
        'high_priority_pending_tasks': high_priority_pending_tasks,
        'recent_tasks': recent_tasks,
        'backlog_tasks':backlog_tasks
    })


def sprint_dashboard(request):
    sprints = Sprint.objects.all()
    backlog_tasks = Task.objects.filter(status="Backlog")
    return render(request, 'sprint_dashboard.html', {'sprints': sprints,'backlog_tasks': backlog_tasks})
def create_sprint(request):
    if request.method == 'POST':
        form = SprintForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('sprint_dashboard')
    else:
        form = SprintForm()
    return render(request, 'create_sprint.html', {'form': form})

def sprint_detail(request, sprint_id):
    sprint = get_object_or_404(Sprint, id=sprint_id)
    sprints = Sprint.objects.all()

   
    pending_tasks = sprint.tasks.filter(status='Pending')
    in_progress_tasks = sprint.tasks.filter(status='In Progress')
    completed_tasks = sprint.tasks.filter(status='Completed')
    backlog_tasks = Task.objects.filter(status="Backlog").exclude(sprints=sprint)

    return render(request, 'sprint_dashboard.html', {
        'sprint': sprint,
        'sprints': sprints,
        'pending_tasks': pending_tasks,
        'in_progress_tasks': in_progress_tasks,
        'completed_tasks': completed_tasks,
        'backlog_tasks': backlog_tasks,
    })


def add_task_to_sprint(request):
    if request.method == 'POST':
        task_id = request.POST.get('task_id')
        sprint_id = request.POST.get('sprint_id')

        if not task_id or not sprint_id:
            messages.error(request, "All fields are required.")
            return redirect('sprint_dashboard')

      
        task = get_object_or_404(Task, id=task_id)
        sprint = get_object_or_404(Sprint, id=sprint_id)

        if task.status == "In Progress":
            sprint.in_progress_tasks.add(task)
        elif task.status == "Completed":
            sprint.completed_tasks.add(task)
        else:
            sprint.pending_tasks.add(task)
            task.status = "Pending"

      
        sprint.tasks.add(task)
        task.save()

        messages.success(request,
                         f"Task '{task.task_name}' added to sprint '{sprint.sprint_name}' with status '{task.status}'.")
        return redirect('sprint_detail', sprint_id=sprint.id)

    return redirect('sprint_dashboard')

def update_task_status(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        task_id = data.get('id')
        new_status = data.get('status')
        try:
            task = Task.objects.get(id=task_id)
            task.status = new_status
            task.save()
            return JsonResponse({'success': True, 'status': task.status})
        except Task.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Task not found'})
    return JsonResponse({'success': False, 'error': 'Invalid request'})


def auth_login(request, user_instance):
    pass


def login(request):
    if request.method == 'POST':
        form = UserLoginForm(request.POST)
        if form.is_valid():
            reg_no = form.cleaned_data['reg_no']
            password = form.cleaned_data['password']

            try:
                user_instance = user.objects.get(reg_no=reg_no)  

                # Check password
                if user_instance.check_password(password):  
                    request.session['user_reg_no'] = user_instance.reg_no  

                 
                    auth_login(request, user_instance)

                    
                    if user_instance.role == 'admin':
                        return redirect('admin_dashboard') 
                    elif user_instance.role == 'employee':
                        return redirect('baseuser')  
                else:
                    return render(request, 'login.html', {'form': form, 'error': 'Invalid credentials'})

            except user.DoesNotExist:
                return render(request, 'login.html', {'form': form, 'error': 'User not found'})

    else:
        form = UserLoginForm()

    return render(request, 'login.html', {'form': form})


