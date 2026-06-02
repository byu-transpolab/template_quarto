# Quarto paper template

This repository is a starter template for a reproducible paper or technical report. It combines three tools:

- `renv` manages the R package environment.
- `targets` runs the analysis pipeline.
- Quarto renders the manuscript as a website and an Elsevier-style PDF.

The example analysis is intentionally lightweight. It uses built-in example data, `tidyverse` data preparation, base R `lm()` models, and `modelsummary` tables and figures. Replace the example data and models with the analysis for your own project.

## Quick start

Open the project from `template_quarto.Rproj`, or start R from this repository's root directory.

Restore the package environment:

```r
renv::restore()
```

Run the analysis pipeline:

```r
targets::tar_make()
```

Render the manuscript:

```sh
quarto render
```

The rendered website and PDF are written to `_book/`. Generated outputs such as `_book/`, `_targets/`, and Quarto cache folders are ignored by Git.

## Project structure

- `_quarto.yml` configures the Quarto book, chapter order, bibliography, and output formats.
- `_targets.R` defines the reproducible analysis pipeline.
- `R/` contains project functions used by the pipeline and manuscript.
- `*.qmd` files are the manuscript chapters.
- `references.bib` stores bibliography entries.
- `packages.tex` stores extra LaTeX packages used by the PDF output.
- `renv.lock` records the R package versions for the project.
- `.Rprofile` activates `renv` whenever R starts in this directory.

## Package management with renv

This repository uses `renv` so that different users can install the same package versions. The `.Rprofile` file runs `source("renv/activate.R")`, which activates the project library when you open the project in R.

The important file is `renv.lock`. It records the package versions needed to reproduce the project. The local package library under `renv/library/` is not meant to be committed; users recreate it with:

```r
renv::restore()
```

When you add, remove, or update packages for your project, update the lockfile after confirming the code works:

```r
renv::snapshot()
```

Keep package use focused. For this template, the expected core packages are `tidyverse`, `targets`, `modelsummary`, `kableExtra`, and `knitr`, plus rendering dependencies needed by Quarto.

## Analysis pipeline with targets

The `targets` pipeline is defined in `_targets.R`. It loads `targets`, sets target options, sources all R scripts in `R/`, and then declares the pipeline targets.

The current example pipeline has two targets:

- `analysis_data`: created by `make_data()` in `R/data_and_models.R`.
- `models`: created by `estimate_models(analysis_data)`.

Run the pipeline before rendering the manuscript:

```r
targets::tar_make()
```

The pipeline stores generated objects in `_targets/`. Manuscript chapters load those objects with `tar_load()`, as in `03_methods.qmd` and `04_results.qmd`. This keeps the manuscript focused on presentation while the data preparation and modeling logic live in R scripts.

Useful commands while developing:

```r
targets::tar_make()
targets::tar_outdated()
targets::tar_read(analysis_data)
targets::tar_load(models)
```

When starting a new project, replace the example functions in `R/data_and_models.R` and update the target names and dependencies in `_targets.R`.

## Manuscript rendering with Quarto

The manuscript is configured as a Quarto book in `_quarto.yml`. The chapter order is:

1. `index.qmd`
2. `01_introduction.qmd`
3. `02_litreview.qmd`
4. `03_methods.qmd`
5. `04_results.qmd`
6. `05_conclusion.qmd`
7. `references.qmd`

The template currently renders to two formats:

- `html`, using the `cosmo` theme.
- `elsevier-pdf`, using the bundled Elsevier Quarto extension and `packages.tex`.

Render all configured outputs with:

```sh
quarto render
```

Render a single format with:

```sh
quarto render --to html
quarto render --to elsevier-pdf
```

Each analysis chapter begins with a setup chunk that uses `R/chapter_start.R`. That file loads the common packages and sets formatting options for tables, inline numbers, and PDF output.

## Suggested workflow

1. Restore packages with `renv::restore()`.
2. Replace the example data and model functions in `R/data_and_models.R`.
3. Update `_targets.R` so the pipeline matches your analysis.
4. Run `targets::tar_make()` until the pipeline completes.
5. Write and revise the `.qmd` manuscript chapters.
6. Render with `quarto render`.
7. If package requirements changed, run `renv::snapshot()` and commit the updated `renv.lock`.
