################################################################################
## Project: Data Reflection on Andromeda Tau (https://www.andromedatau.com/)
##
## Script purpose: Analysis accessibility errors and the use of accessibility 
##                  statements.
##
## Author: Bryan Nelson
##    Email: bryan@andromedatau.com
##    Github: https://github.com/bnlsn
## 
## Creation Date: 2021-01-04
## Updated Date: 2021-01-06
################################################################################

# Load libraries
library(tidyverse)

# Import data from Github

# Data source: Top 50 websites by US visitors (as indicated by Similarweb, as of 
# November 2021), assessed by the WebAIM extension to detect accessibility
# errors and contrast errors.
top_50_websites <- read.csv("https://raw.githubusercontent.com/bnlsn/blog-data/main/digital-accessibility/Accessibility-Top-50.csv")

# View top three rows, piped to knitr::kable to ensure output meets contrast
# requirements in browser
head(top_50_websites, 3) %>%
  knitr::kable()

# Plot histogram of errors
ggplot(data = top_50_websites, aes(x = Errors)) +
  geom_histogram()

# Plot histogram of contrast errors
ggplot(data = top_50_websites, aes(x = Contrast.Errors)) +
  geom_histogram()

# Create table of the average errors and contrast errors, group by website
# category
top_50_websites %>%
  group_by(Category) %>%
  summarise_at(c("Errors", "Contrast.Errors"), mean) %>%
  arrange(-Errors) %>%
  knitr::kable(digits = 1)

# Create table of average errors and contrasts errors, grouped by whether or
# not an accessibility statement is present
top_50_websites %>%
  group_by(Accessibility.Statement) %>%
  summarise_at(c("Errors", "Contrast.Errors"), mean) %>%
  knitr::kable(digits = 1)

# Create scatter plot of errors and contrast errors, using color and shapes (for
# accessibility reasons) to denote the presence of an accessibility statement.
# Color choices have have been chosen with colorblindness in mind.
ggplot(data = top_50_websites, aes(x = Errors, y = Contrast.Errors, 
                                   color = Accessibility.Statement, 
                                   shape = Accessibility.Statement)) +
  geom_point() +
  scale_fill_manual(values=c("#E66100", "#5D3A9B"))

