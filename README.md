# Quarto template

This repository creates a template article that can be converted into a website, an academic article PDF, and (eventually) a BYU Engineering thesis. This template also implements the workflow presented in my [lab documentation](https://gregmacfarlane.github.io/lab/workflow.html).

## Rendering

To render this document, use the command `quarto render` in your terminal pointed at the working directory.

By default, this project is set up to create a website and an Elsevier journal article PDF. You can change the article to a different publisher by following the directions at the [Quarto Journal Templates GitHub](https://github.com/quarto-journals) repository.

To render your website *and* push its content to a live website, use the command `quarto publish gh-pages` . Details of this process are available on the [Quarto guide](https://quarto.org/docs/publishing/github-pages.html#publish-command).
