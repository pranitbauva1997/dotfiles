# FastAPI

<preferences>
Always use `async` with network requests, DB calls, and everywhere else possible
Always do thorough request validation and sanitize the inputs
Always check if the endpoint requires authentication and authorization
Always use pydantic models for request, response, DB fetches, DB inserts/updates
Always use database connection pooling
Write raw SQLs interacting directly with database
Create a custom exception hierarchy
Add a global exception handler
Write detailed OpenAPI documentation
Use lifespan events for startup/shutdown
</preferences>

<other_references>
Python `@~/.claude/docs/python.md`
Pydantic `@~/.claude/docs/pydantic.md`
</other_references>
