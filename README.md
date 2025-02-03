
# Marbec-DEN website repository

## How to build in local?

### Install Hugo

Follow the instructions at [goHugo](https://gohugo.io/installation/windows/), but basically is about to install [Git](https://git-scm.com/) and [Go](https://go.dev/), and then use Winget to [install Hugo](https://gohugo.io/installation/windows/#winget)

### Build and serve the website locally

- Mode 1
  - Open a Terminal in the root
  - Run `quarto render && hugo server --disableFastRender`

- Mode 2 (Windows)
  - Open .RProj in RStudio.
  - In the Terminal panel, run `sh ./render_and_serve.sh`

### To-Do

- Check section tree.
- Add Search ability (specially for Manual & Guides).
- Fill **Courses and Resources** section.
- Fill **Contact** section.
- Improve color palette.
- Improve design (titles/subtitles, navbar width, fonts, reference links).
- Improve (re-do) the content of **Home** and **About**.
- Change main banner image (use an image of a Marbec member perhaps?).
