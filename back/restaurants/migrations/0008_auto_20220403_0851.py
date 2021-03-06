# Generated by Django 3.2.8 on 2022-04-03 08:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restaurants', '0007_auto_20211031_1604'),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('image', models.ImageField(blank=True, null=True, upload_to='category_image')),
            ],
        ),
        migrations.AddField(
            model_name='restaurant',
            name='categories',
            field=models.ManyToManyField(to='restaurants.Category'),
        ),
    ]
