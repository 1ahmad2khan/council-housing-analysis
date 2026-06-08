# Council Housing & Planning Analysis

This project looks at housing and planning application data from a local 
council to understand where development is happening, how decisions are 
being made, and whether there are patterns worth paying attention to.

The work is structured the way a BI team in local government would 
approach it — starting with raw data, cleaning it up, then working through 
the questions that actually matter to planners and senior officers.

What I was trying to find out

- Where is development activity concentrated and is that changing over time?
- What share of planning applications get approved, and does that vary by 
  application type?
- How long are decisions taking, and are some application types consistently 
  slower than others?
- Are application volumes growing, shrinking, or staying flat year on year?

Tools

- Python and Pandas — data cleaning and exploration
- SQL — querying and aggregating
- Matplotlib and Seaborn — charts and visualisations
- Power BI — final dashboard

Structure

    data/          raw and cleaned datasets
    notebooks/     Python analysis
    sql/           queries
    dashboard/     charts and Power BI files
    docs/          findings and recommendations

Key Findings

- Planning applications nationally peaked in 2003-2004 and have declined steadily since 2008
- The South West is the third most active region in England for planning applications
- Gloucester peaked at ~5,300 applications in 2003 and now receives around 2,000-2,500 annually
- The gap between applications received and decided has narrowed significantly since 2010
- South Gloucestershire, Cotswold and Stroud all rank higher in the South West — 
  pointing to strong development pressure across the wider Gloucestershire area

Full findings in the [business report](docs/business_report.md)

Status

Analysis complete.