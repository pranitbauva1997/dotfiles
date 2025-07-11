# UV package manager for python

<preferences>
</preferences>

<commands>
<command>`uv --version`: verify installation; exits 0</command>
<command>`uv init myproj`: create pyproject.toml + .venv</command>
<command>`uv add ruff pytest httpx`: fast resolver + lock update</command>
<command>`uv run pytest -q`: run tests in project venv</command>
<command>`uv lock`: refresh uv.lock (if needed)</command>
<command>`uv sync --locked`: reproducible install (CI‑safe)</command>
<command>`uv run hello.py`: zero‑dep script, auto‑env</command>
<command>`uv add --script hello.py rich`: embeds dep metadata</command>
<command>`uv run --with rich hello.py`: transient deps, no state</command>
<command>`uvx ruff check .`: ephemeral run</command>
<command>`uv tool install ruff`: user‑wide persistent install</command>
<command>`uv tool list`: audit installed CLIs</command>
<command>`uv tool update --all`: keep them fresh</command>
<command>`uv python install 3.10 3.11 3.12`: Install multiple Python versions</command>
<command>`uv python pin 3.12`: writes .python-version</command>
<command>`uv run --python 3.10 script.py`: Run a script with a specific Python version</command>
<command>`uv venv .venv`: Create a virtual environment</command>
<command>`uv pip install -r requirements.txt`: Install from a requirements file</command>
<command>`uv pip sync -r requirements.txt`: deterministic install</command>
<command>`uv cache dir`: show path + stats</command>
<command>`uv cache info`: show path + stats</command>
<command>`uv cache clean`: wipe wheels & sources</command>
<command>`uv python install`: obey .python-version</command>
<command>`uv sync --locked`: restore env</command>
<command>`uv run pytest -q`: Run tests</command>
<command>`uv sync --production --locked`: Install production dependencies from lockfile</command>
<command>`uv run python -m myapp`: Run the application module</command>
<command>`uv venv`: One‑Shot Replacement for `python -m venv`</command>
<command>`uv pip install`: One‑Shot Replacement for `pip install`</command>
<command>`uv pip compile`: One‑Shot Replacement for `pip-tools compile`</command>
<command>`uvx`: One‑Shot Replacement for `pipx run`</command>
<command>`uv tool run`: One‑Shot Replacement for `pipx run`</command>
<command>`uv add`: One‑Shot Replacement for `poetry add`</command>
<command>`uv python install`: One‑Shot Replacement for `pyenv install`</command>
<command>`uv python install X.Y`: Resolution for `Python X.Y not found`</command>
<command>`uv cache clean`: Part of the resolution for needing a fresh environment</command>
<command>`uv sync`: Part of the resolution for needing a fresh environment</command>
<command>`uv ...`: Used for debugging when still stuck</command>
<command>`uv init myproj`: new project</command>
<command>`uv add requests rich`: add dependencies</command>
<command>`uv run python -m myproj ...`: test run</command>
<command>`uv lock`: lock + CI restore</command>
<command>`uv sync --locked`: lock + CI restore</command>
<command>`uv add --script tool.py httpx`: adhoc script</command>
<command>`uv run tool.py`: adhoc script</command>
<command>`uvx ruff check .`: manage CLI tools</command>
<command>`uv tool install pre-commit`: manage CLI tools</command>
<command>`uv python install 3.12`: Python versions</command>
<command>`uv python pin 3.12`: Python versions</command>
</commands>

<other_references>
Python `@/.claude/docs/python.md`
</other_references>
