
# Gene Text Input Module UI function

report_ui <- function(id) {
  
  ns <- NS(id)
  
  tagList(
    use_waiter(),
    use_hostess(), 
    
    fluidRow(
     column(width = 2, 
            textInput(ns("genes"), "Enter gene target(s) (HGNC Symbols) separated by commas", placeholder = "e.g. AKT1, NRXN1"),
            downloadButton(ns("dl"), label = "Generate Report")

            ),
     column(width = 10, 
            hostess_loader("load", text_color = "black",
                           center_page = TRUE, min = 15,
                           svg = "images/ks_logo_new.svg",  progress_type = "fill"),
            includeHTML("www/report_tab_ui.html")
     
  )
  
    
  )
  )

}

# Gene Text Input Module Server function

generate_html_report <- function(input_genes, file_path) {
  temp_path <- file.path(tempdir(), "ks-report.Rmd")
  file.copy(paste0("www/", "ks-report.Rmd"), temp_path, overwrite = TRUE)
  
  temp_path_logo <- file.path(tempdir(), "ks_new_logo.svg")
  file.copy(paste0("www/", "assets/images/ks_new_logo.svg"), temp_path_logo, overwrite = TRUE)
  
  temp_path_js <- file.path(tempdir(), "string_embedded_network_v2.0.2.js")
  file.copy("www/string_embedded_network_v2.0.2.js", temp_path_js, overwrite = TRUE)
  
  param_list <- list(gene = input_genes, 
                     brainrnaseq = input$brainseq_par,
                     ilincs = input$ilincs_par,
                     gwas = input$gwas_par,
                     braincloud = input$braincloud_par,
                     string = input$string_par,
                     brainatlas = input$brainatlas_par,
                     gtex = input$gtex_par
  )
  
  rmarkdown::render(input = temp_path,
                    output_format = rmarkdown::html_document(),
                    output_file = file_path,
                    params = param_list,
                    envir = new.env()
  )
}

generate_pdf_report <- function(input_genes, file_path) {
  temp_path <- file.path(tempdir(), "ks-reportpdf.Rmd")
  file.copy(paste0("www/", "ks-reportpdf.Rmd"), temp_path, overwrite = TRUE)
  
  temp_path_logo <- file.path(tempdir(), "ks_new_logo.svg")
  file.copy(paste0("www/", "assets/images/ks_new_logo.svg"), temp_path_logo, overwrite = TRUE)
  
  temp_path_js <- file.path(tempdir(), "string_embedded_network_v2.0.2.js")
  file.copy("www/string_embedded_network_v2.0.2.js", temp_path_js, overwrite = TRUE)
  
  param_list <- list(gene = input_genes, 
                     brainrnaseq = input$brainseq_par,
                     ilincs = input$ilincs_par,
                     gwas = input$gwas_par,
                     braincloud = input$braincloud_par,
                     string = input$string_par,
                     brainatlas = input$brainatlas_par,
                     gtex = input$gtex_par
  )
    
  rmarkdown::render(input = temp_path,
                    output_format = pdf_document(),
                    output_file = file_path,
                    params = param_list,
                    envir = new.env()
  )
}

