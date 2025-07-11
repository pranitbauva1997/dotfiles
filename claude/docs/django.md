# Django

<preferences>
  Prefer function based views over class based views.
  Use the default django ORM.
  Always use the custom defined user model instead of the default/in-built one
  Create a `services.py` file/module for complex operations over bloating the views
  Implement __str__: For better admin interface and debugging
  For ORMs, django models, SQL:
   - Always add a newly created model to the admin interface
   - Use `select_related` and `prefetch_related` to solve N+1 query problem in ORM especially in one-to-many and many-to-many relationships between django models/sql tables
   - Use pagination: For large querysets
   - Use `only()` and `defer()` to control which fields are loaded
   - Use `count()` instead of `len(queryset)` when you only need the count
   - Use `exists()` instead of `if queryset:` when checking for existence
   - Use Django's transaction.atomic for database operations that need to succeed or fail together
   - Always use `TextField` over `CharField`
   - Use `DecimalField` for money/currency over `FloatField`
   - Use `UUIDField` instead of auto-increment PKs
   - Use `DateTimeField` for timestamps (with `auto_now_add`/`auto_now`)
   - Set `verbose_name` for django admin interface
   - Be extra careful around `on_delete`
   - Define custom methods inside the model which can be re-used multiple times
   - Always think hard about field, model validations and permissions
   - Use abstract base model for leveraging common fields/columns like this:
      ```python
      class TimestampedModel(models.Model):
        created_at = models.DateTimeField(auto_now_add=True)
        updated_at = models.DateTimeField(auto_now=True)

        class Meta:
            abstract = True
      ```
  Templates:
   - Use template inheritance: With `{% extends %}` and `{% block %}`.
   - Limit logic in templates: Complex logic belongs in views or models
   - Use template tags/filters: For reusable presentation logic
   - Use `{% static %}` template tag for all static file references
   - Use `{% url %}` instead of hard-coding URLs
   - Use partial templates and prefix them with `_`
   - Business logic always in python and leverage template tags and filters
   - Group related templates in directories:
     - `partials/` for reusable components
     - `email/` for email templates
     - `admin/` for custom admin templates
   - Use named Block Strategies in templates:
     - `{% block meta %}` - For meta tags and SEO
     - `{% block css %}` - For stylesheet includes
     - `{% block header_scripts %}` - For scripts needed in head
     - `{% block content %}` - Main content area
     - `{% block footer_scripts %}` - For deferred JavaScript
     - `{% block modals %}` - For modal dialogs
  Forms:
   - Always validate incoming form inputs in the backend as well as the frontend
   - Build validation where form is defined and always call `is_valid()`
  Requests:
   - Always create separate for handling different HTTP methods like `GET`, `POST`, etc
   - Always validate inputs
  Responses:
   - Use `reverse()` instead of hard-coding URLs
   - Return appropriate HTTP status code for errors
   - Always validate file paths
  Authentication & Authorization:
   - Check for roles and permissions whether the operation is allowed
   - Use `@login_required` for authentication.
  URLs:
   - Implement URL namespacing, nested namespaces wherever required and consistent naming
   - Validate URL parameters in views
</preferences>

<other_references>
  Python `@~/.claude/docs/python.md`
  SQL `@~/.claude/docs/sql.md`
</other_references>
