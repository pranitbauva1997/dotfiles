# Python

<preferences>
Always use type hints for function arguments, return types, class attribute definition.
Use structured logging with `logging.info` `logging.debug` and pass extra context of variables defined or updated around it.
List comprehensions (`map`, `filter`, `sum`) over manual loops
Context managers (`with` statement) for resource handling to ensure files, locks and connections are always closed
Create custom context managers using `contextlib` where it fits the use case
Generators (`yield`) for memory-efficient iteration
Handle edge-cases explicitly (empty lists, `None` values, etc) and surface them
Use collections (`defaultDict`, `Counter`, sets) for efficient data handling
Use `numpy` and `pandas` for numerical heavy work since they do vectorized operations
Use `functools.lru_cache` function decorator for memoizing expensive operations
Prefer catching specific exceptions
Use `hashlib` for secure password hashing
Use `secrets` for generating random passwords/strings/tokens etc
For API/data validation use pydantic
Use `NamedTuple` or `@dataclass(frozen=True)` to prevent accidental mutations
For string concatenation, use `.join()`, or f-strings
In logging, always pass the variables as an argument instead of constructing f-strings
Use `memoryview` for zero-copy operations when the data doesn't need to be modified
Use asyncio for I/O bound tasks, `multiprocessing` for CPU-bound work, `ThreadPoolExecutor` for mixed workloads
Try using `else` with `try/catch` that runs only if no exceptions occur and use `finally` for cleanups
Always retry flaky operations (network calls, DB calls, etc) using `tencity` package's `@retry` decorator and set the `stop_after_attempt` to `3`
In the exception block, log using `logging.exception`
Use `bisect` for fast searches in sorted lists
Always use parameterized queries with SQL
Use `asyncio.gather()` for parallel tasks
Use `asyncio.wait_for()` to avoid hanging forever
Async exceptions must be caught inside coroutines:
```python
async def safe_fetch(url):
  try:
      return await fetch(url)
  except aiohttp.ClientError as e:
      print(f"Failed: {e}")
      return None
```
</preferences>

<other_references>
Pydantic `@~/.claude/docs/pydantic.md`
Django `@~/.claude/docs/django.md`
FastAPI `@~/.claude/docs/fastapi.md`
Pydantic `@~/.claude/docs/pydantic.md`
Numpy `@~/.claude/docs/numpy.md`
Pandas `@~/.claude/docs/pandas.md`
UV `@~/.claude/docs/uv.md`
API Design `@~/.claude/api_design.md`
<other_references>
