

from django.urls import path
from . import views
from .views import *

urlpatterns = [
    path("baseuser", baseuser, name='baseuser'),

    path('task/update/<int:task_id>/', views.update_task, name='update_task'),
    path('task/<int:task_id>/', task_details, name='task_details'),
    path('emp_task_list',emp_task_list,name='emp_task_list'),
    path('employee_projects',employee_projects,name='employee_projects'),


    path('employee_dashboard/', employee_dashboard, name='employee_dashboard'),
    path('project_overview/<int:project_id>/', project_overview, name='project_overview'),


    path("logout/", logout_view, name="logout"),

]