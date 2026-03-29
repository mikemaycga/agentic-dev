# AI/ML Pipeline Project

## Project Type
AI/ML pipeline (Python, data processing, model training/inference)

## Standards
@framework/standards/code-style.md
@framework/standards/testing-standards.md
@framework/standards/security-baseline.md
@framework/standards/git-workflow.md

## Tech Stack
- **Language:** Python 3.11+
- **ML Frameworks:** PyTorch, scikit-learn, or as specified
- **Data Processing:** Pandas, Polars, or DuckDB
- **API Serving:** FastAPI for model endpoints
- **Testing:** pytest with fixtures for data mocking
- **Environment:** Virtual environments (venv or conda)

## Project Conventions
- Data pipelines in `pipelines/`
- Model definitions in `models/`
- Training scripts in `training/`
- Inference/serving in `serving/`
- Notebooks in `notebooks/` (exploratory only — production code in `.py` files)
- Data schemas documented in `schemas/`

## Data Security
- No raw client data in Git repositories
- Model artifacts stored via Git LFS or external artifact store
- API keys for model providers in environment variables only

## Security Profile
Default: professional-standard. Projects with PII/PHI data use enterprise-soc2.
