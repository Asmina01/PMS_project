# Generated by Django 4.2.14 on 2025-01-23 05:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('admin_app', '0002_remove_task_sprint'),
    ]

    operations = [
        migrations.AddField(
            model_name='sprint',
            name='tasks',
            field=models.ManyToManyField(blank=True, related_name='sprints', to='admin_app.task'),
        ),
    ]
