from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

from admin_app.models import *

class TaskTime(models.Model):
    task = models.ForeignKey(Task, related_name='task_times', on_delete=models.CASCADE)
    start_time = models.DateTimeField(null=True, blank=True)
    stop_time = models.DateTimeField(null=True, blank=True)
    completed_time = models.DateTimeField(null=True, blank=True)

    @property
    def time_spent(self):
        if self.start_time and self.stop_time:
            delta = self.stop_time - self.start_time
            return delta  
        return None




class Comment(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comment by {self.user.name} on {self.project.name}"

