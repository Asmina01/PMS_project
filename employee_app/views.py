from django.db.models import Q

from django.http import HttpResponseRedirect

from django.shortcuts import render, redirect, get_object_or_404


from admin_app.models import *
from .forms import CommentForm
from .models import *

from employee_app.models import TaskTime




def task_details(request, task_id):
    task = get_object_or_404(Task, id=task_id)

    # Get the latest time entry for the task
    task_time = task.times.last() if task.times.exists() else None

    if task_time:
        # Calculate time spent if the task is completed
        if task_time.stop_time:
            time_spent = task_time.stop_time - task_time.start_time
        else:
            time_spent = timezone.now() - task_time.start_time
    else:
        time_spent = None

    return render(request, 'employee/task_details.html', {
        'task': task,
        'time_spent': time_spent,
    })
def update_task(request, task_id):
    task = get_object_or_404(Task, id=task_id)

    if request.method == 'POST':
        # Check if the timer is being started
        if 'start_time' in request.POST:
            if task.status == "Pending":  # Automatically change status to "In Progress" if it's pending
                task.status = "In Progress"

        # Handle the status update
        if 'status' in request.POST:
            new_status = request.POST['status']
            if new_status == "Completed" and task.status != "Completed":  # Only update if it's being completed now
                # Save current timestamp when task is completed in TaskTime model
                TaskTime.objects.create(
                    task=task,
                    stop_time=timezone.now()  # Store the current timestamp as the stop_time
                )
            task.status = new_status

        # Handle the timer data (start_time and stop_time)
        start_time = request.POST.get('start_time')
        stop_time = request.POST.get('stop_time')

        # Save the start and stop time to TaskTime model
        if start_time and stop_time:
            TaskTime.objects.create(
                task=task,
                start_time=start_time,
                stop_time=stop_time
            )

        # Handle checkbox for marking the task as completed
        if 'is_completed' in request.POST and request.POST['is_completed'] == 'on':
            task.status = "Completed"

        task.save()

        return redirect('baseuser')  # Redirect to the task list page

    latest_time = task.task_times.last()

    return render(request, 'employee/update_task.html', {'task': task, 'latest_time': latest_time})
# View to list all tasks
def emp_task_list(request):
    # Ensure the user is logged in
    if 'user_reg_no' not in request.session:
        return redirect('login')

    # Get the logged-in user instance
    user_instance = user.objects.get(reg_no=request.session['user_reg_no'])

    # Retrieve GET parameters
    hide_completed = request.GET.get('hide_completed')
    search_query = request.GET.get('search', '').strip()
    status_filter = request.GET.get('status', '')
    category_filter = request.GET.get('category', '')
    priority_filter = request.GET.get('priority', '')
    project_filter = request.GET.get('project', '')
    start_date = request.GET.get('start_date', '')
    due_date = request.GET.get('due_date', '')
    estimated_hours = request.GET.get('estimated_hours', '')

    # Base queryset
    tasks = Task.objects.filter(assigned_to=user_instance)

    # Apply filters
    if hide_completed == 'on':
        tasks = tasks.exclude(status='Completed')
    if search_query:
        tasks = tasks.filter(Q(task_name__icontains=search_query))
    if status_filter:
        tasks = tasks.filter(status=status_filter)
    if category_filter:
        tasks = tasks.filter(category=category_filter)
    if priority_filter:
        tasks = tasks.filter(priority=priority_filter)
    if project_filter:
        tasks = tasks.filter(project__id=project_filter)
    if start_date:
        tasks = tasks.filter(start_date__gte=start_date)
    if due_date:
        tasks = tasks.filter(due_date__lte=due_date)
    if estimated_hours:
        tasks = tasks.filter(estimated_hours__gte=estimated_hours)

    # Calculate time spent on tasks and get completed time
    for task in tasks:
        total_seconds = sum((entry.stop_time - entry.start_time).total_seconds()
                            for entry in task.task_times.all() if entry.start_time and entry.stop_time)
        task.total_hours = int(total_seconds // 3600)
        task.total_minutes = int((total_seconds % 3600) // 60)

        # Get completed time from the last TaskTime entry if task is completed
        completed_time = task.task_times.filter(stop_time__isnull=False).order_by('-stop_time').first()
        task.completed_time_display = completed_time.stop_time if completed_time else None

    return render(request, 'employee/emp_task_list.html', {
        'tasks': tasks,
        'hide_completed': hide_completed,
        'search_query': search_query,
        'status_filter': status_filter,
        'category_filter': category_filter,
        'priority_filter': priority_filter,
        'project_filter': project_filter,
        'start_date': start_date,
        'due_date': due_date,
        'estimated_hours': estimated_hours,
    })

def employee_dashboard(request):
    if 'user_reg_no' not in request.session:
        return redirect('login')  # Redirect to login if not authenticated

    user_instance = user.objects.get(reg_no=request.session['user_reg_no'])  # Fetch the logged-in user
    return render(request, 'employee/employee_dashboard.html', {'user': user_instance})


from django.utils import timezone


def baseuser(request):
    if 'user_reg_no' not in request.session:
        return redirect('login')  # Redirect to login if not authenticated

    user_instance = user.objects.get(reg_no=request.session['user_reg_no'])
    tasks = Task.objects.filter(assigned_to=user_instance)

    total_tasks = tasks.count()
    completed_tasks = tasks.filter(status='Completed').count()
    pending_tasks = tasks.filter(status='Pending').count()
    in_progress_tasks = tasks.filter(status='In Progress').count()

    # Assume each working day has 8 hours
    working_hours_per_day = 8
    total_working_hours = total_tasks * working_hours_per_day

    # Get today's date
    today = timezone.localdate()

    # Filter TaskTime entries for today
    today_task_times = TaskTime.objects.filter(task__assigned_to=user_instance, start_time__date=today)

    # Calculate total hours worked today
    total_seconds_today = sum(
        (entry.stop_time - entry.start_time).total_seconds()
        if entry.stop_time else (timezone.now() - entry.start_time).total_seconds()
        for entry in today_task_times
    )

    for task in tasks:
        total_seconds = sum((entry.stop_time - entry.start_time).total_seconds()
                            for entry in task.task_times.all() if entry.start_time and entry.stop_time)
        task.total_hours = int(total_seconds // 3600)
        task.total_minutes = int((total_seconds % 3600) // 60)

    total_hours_today = int(total_seconds_today // 3600)
    total_minutes_today = int((total_seconds_today % 3600) // 60)

    # Retrieve GET parameters
    hide_completed = request.GET.get('hide_completed')
    search_query = request.GET.get('search', '').strip()
    status_filter = request.GET.get('status', '')
    category_filter = request.GET.get('category', '')
    priority_filter = request.GET.get('priority', '')
    project_filter = request.GET.get('project', '')
    start_date = request.GET.get('start_date', '')
    due_date = request.GET.get('due_date', '')
    estimated_hours = request.GET.get('estimated_hours', '')

    # Base queryset
    tasks = Task.objects.filter(assigned_to=user_instance)

    # Apply filters
    if hide_completed == 'on':
        tasks = tasks.exclude(status='Completed')
    if search_query:
        tasks = tasks.filter(Q(task_name__icontains=search_query))
    if status_filter:
        tasks = tasks.filter(status=status_filter)
    if category_filter:
        tasks = tasks.filter(category=category_filter)
    if priority_filter:
        tasks = tasks.filter(priority=priority_filter)
    if project_filter:
        tasks = tasks.filter(project__id=project_filter)
    if start_date:
        tasks = tasks.filter(start_date__gte=start_date)
    if due_date:
        tasks = tasks.filter(due_date__lte=due_date)
    if estimated_hours:
        tasks = tasks.filter(estimated_hours__gte=estimated_hours)

    # Calculate time spent on tasks
    for task in tasks:
        total_seconds = sum((entry.stop_time - entry.start_time).total_seconds()
                            for entry in task.task_times.all() if entry.start_time and entry.stop_time)
        task.total_hours = int(total_seconds // 3600)
        task.total_minutes = int((total_seconds % 3600) // 60)

        completed_time = task.task_times.filter(stop_time__isnull=False).order_by('-stop_time').first()
        task.completed_time_display = completed_time.stop_time if completed_time else None



    context = {
        'user': user_instance,
        'tasks': tasks,
        'total_tasks': total_tasks,
        'completed_tasks': completed_tasks,
        'pending_tasks': pending_tasks,
        'in_progress_tasks': in_progress_tasks,
        'total_working_hours': total_working_hours,
        'total_hours_today': total_hours_today,
        'total_minutes_today': total_minutes_today,
        'search_query': search_query,
        'status_filter': status_filter,
        'category_filter': category_filter,
        'priority_filter': priority_filter,
        'project_filter': project_filter,
        'start_date': start_date,
        'due_date': due_date,
        'hide_completed': hide_completed,
        'estimated_hours': estimated_hours,
    }

    return render(request, 'employee/baseuser.html', context)

def logout_view(request):
    request.session.flush()  # Clear session data
    return redirect('login')


def employee_projects(request):
    # Ensure the user is logged in
    if 'user_reg_no' not in request.session:
        return redirect('login')

    # Get the logged-in user instance
    user_instance = user.objects.get(reg_no=request.session['user_reg_no'])

    # Get filter parameters from the request
    status_filter = request.GET.get('status', '')
    priority_filter = request.GET.get('priority', '')
    category_filter = request.GET.get('category', '')
    start_date = request.GET.get('start_date', '')
    due_date = request.GET.get('due_date', '')
    no_deadline = request.GET.get('no_deadline', '')
    client_filter = request.GET.get('client', '')
    search_query = request.GET.get('search', '')

    # Start with projects assigned to the logged-in employee
    projects = Project.objects.filter(assigned=user_instance)

    # Apply filters if provided
    if status_filter:
        projects = projects.filter(status=status_filter)
    if priority_filter:
        projects = projects.filter(priority=priority_filter)
    if category_filter:
        projects = projects.filter(category=category_filter)
    if start_date:
        projects = projects.filter(start_date__gte=start_date)
    if due_date:
        projects = projects.filter(due_date__lte=due_date)
    if no_deadline:  # Check if "No Deadline" is selected
        projects = projects.filter(due_date__isnull=True)
    if client_filter:  # Filter by client if provided
        projects = projects.filter(client=client_filter)

    # Apply search filter
    if search_query:
        projects = projects.filter(
            Q(name__icontains=search_query) |
            Q(assigned_to__name__icontains=search_query)  # Ensure field name matches your model
        ).distinct()

    total_projects = projects.count()  # Count total number of projects

    clients = Project.objects.values_list('client', flat=True).distinct()

    # Pass current filters to the template for maintaining state
    context = {
        'projects': projects,
        'total_projects': total_projects,
        'status_filter': status_filter,
        'priority_filter': priority_filter,
        'category_filter': category_filter,
        'search_query': search_query,
        'start_date': start_date,
        'due_date': due_date,
        'no_deadline': no_deadline,
        'client_filter': client_filter,
        'clients': clients
    }

    return render(request, 'employee/employee_projects.html', context)



def project_overview(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    comments = Comment.objects.filter(project=project).order_by('-created_at')

    if request.method == 'POST' and request.user.is_authenticated:
        form = CommentForm(request.POST)  # Instantiate the form with the POST data
        if form.is_valid():  # Check if the form is valid
            comment = form.save(commit=False)  # Create a Comment instance, but don't save yet
            comment.user = request.user  # Assign the current user to the comment
            comment.project = project  # Assign the current project to the comment
            comment.save()  # Save the comment to the database
            return HttpResponseRedirect(request.path)  # Redirect to avoid form resubmission
        else:
            print(form.errors)  # Print form validation errors to the console
    else:
        form = CommentForm()  # If it's a GET request, just initialize an empty form

    return render(request, 'employee/project_overview.html', {'project': project, 'comments': comments, 'form': form})