from django.db import models

from django.contrib.auth.hashers import make_password, check_password

class user(models.Model):
    reg_no = models.CharField(max_length=50, primary_key=True)  # Set primary key explicitly
    name = models.CharField(max_length=100)
    designation = models.CharField(max_length=100)
    image = models.ImageField(upload_to='images/', blank=True, null=True)
    phone = models.CharField(max_length=15)
    email = models.CharField(max_length=100)
    password = models.CharField(max_length=255)  # Add password field

    ROLE_CHOICES = (
        ('admin', 'Admin'),
        ('employee', 'Employee'),
    )
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='employee')

    def __str__(self):
        return self.name

    def set_password(self, raw_password):
        self.password = make_password(raw_password)

    def check_password(self, raw_password):
        return check_password(raw_password, self.password)






class Project(models.Model):



    CATEGORY_CHOICES = [
        ('Web Development', 'Web Development'),
        ('Mobile App', 'Mobile App'),
        ('Data Analysis', 'Data Analysis'),
        ('Marketing', 'Marketing'),
        ('Digital Marketing', 'Digital Marketing'),
        ('Others', 'Others'),
    ]

    STATUS_CHOICES = [
        ('Pending', 'Pending'),
        ('Ongoing', 'Ongoing'),
        ('Completed', 'Completed'),
    ]

    PRIORITY_CHOICES = [
        ('Low', 'Low'),
        ('Medium', 'Medium'),
        ('High', 'High'),
    ]

    name = models.CharField(max_length=100)
    short_code = models.CharField(max_length=20, unique=True)  # Unique short code
    description = models.TextField()
    client = models.CharField(max_length=100)
    category = models.CharField(
        max_length=50,
        choices=CATEGORY_CHOICES,
        default='Others'
    )
    files = models.FileField(upload_to='files/', blank=True, null=True)
    assigned = models.ManyToManyField(user, related_name='assigned_projects')
    budget = models.CharField(max_length=100)
    start_date = models.DateField()
    due_date = models.DateField(blank=True, null=True)
    progress = models.FloatField(default=0)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='Pending'
    )
    priority = models.CharField(
        max_length=10,
        choices=PRIORITY_CHOICES,
        default='Medium'
    )

    def __str__(self):
        return self.name

    @property
    def has_deadline(self):
        """Checks if the project has a deadline."""
        return self.due_date is not None






class Sprint(models.Model):
    sprint_name = models.CharField(max_length=100)
    start_date = models.DateField()
    end_date = models.DateField()
    description = models.TextField(blank=True, null=True)
    tasks = models.ManyToManyField('Task', blank=True, related_name='sprints')

    # Separate task lists based on their statuses
    pending_tasks = models.ManyToManyField('Task', blank=True, related_name='pending_sprints')
    in_progress_tasks = models.ManyToManyField('Task', blank=True, related_name='in_progress_sprints')
    completed_tasks = models.ManyToManyField('Task', blank=True, related_name='completed_sprints')

    def __str__(self):
        return self.sprint_name

    def is_completed(self):
        """ Check if all tasks in this sprint are completed """
        return self.tasks.filter(status='completed').count() == self.tasks.count()



class Task(models.Model):
    CATEGORY_CHOICES = [
        ('Testing', 'Testing'),
        ('UI design', 'UI design'),
        ('Bug', 'Bug'),
        ('Support', 'Support'),
        ('Front end', 'Front end'),
        ('Database','Database'),
        ('Others', 'Others'),
    ]

    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='tasks')
    task_name = models.CharField(max_length=100)
    description = models.TextField()
    category = models.CharField(
        max_length=50,
        choices=CATEGORY_CHOICES,
        default='Others'
    )
    assigned_to = models.ManyToManyField(user, related_name='tasks_assigned')
    priority = models.CharField(
        max_length=20,
        choices=[('Low', 'Low'), ('Medium', 'Medium'), ('High', 'High')],
    )
    status = models.CharField(
        max_length=50,
        choices=[('Pending', 'Pending'), ('In Progress', 'In Progress'), ('Completed', 'Completed'), ('Backlog','Backlog')],
        default='Backlog'
    )
    start_date = models.DateField()
    due_date = models.DateField(blank=True, null=True)

    estimated_hours = models.PositiveIntegerField(help_text="Estimated hours to complete the task.")


    def __str__(self):
        return self.task_name

    @property
    def has_deadline(self):
        """Checks if the project has a deadline."""
        return self.due_date is not None

class Taskprogress(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE, related_name='time_logs')
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField(null=True, blank=True)

    def duration(self):
        if self.end_time:
            return (self.end_time - self.start_time).total_seconds() / 3600  # Return hours
        return 0

