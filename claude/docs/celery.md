# Celery

<preferences>
Set timezone as UTC
Use JSON-serializable arguments or implement custom serializers
Use task retries with exponential backoff and jitter
Use acks_late=True for long-running tasks to prevent re-execution if worker crashes
Maintain configuration for different queues
Configure prefetch multiplier
</preferences>

<other_references>
Python `@/.claude/docs/python.md`
</other_references>
