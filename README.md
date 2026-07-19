# Ahmed Nabil Cv Project (Latex)

This is your modularized CV project with separate files for each section to improve organization and maintainability.

## Project Structure

```
cv-project/
├── main.tex              # Main file - compile this
├── README.md             # This file
├── config/
│   └── preamble.tex      # All LaTeX packages, configurations, and custom commands
└── sections/
    ├── header.tex        # Header with name, title, and contact information
    ├── experience.tex    # Work experience section
    ├── skills.tex        # Skills section
    ├── education.tex     # Education section
    └── projects.tex      # Projects section
```

## How It Works

- **config/preamble.tex**: Contains all package imports and global configurations (geometry, colors, environments, etc.). This is loaded once and shared across all sections.
- **sections/*.tex**: Each section file contains a specific part of your CV.
- **main.tex**: The main file that imports the preamble and all sections in order.
