files2rm <- list.files(path = "content/manualsguides/", pattern = "\\.md$", 
                       full.names = TRUE, recursive = TRUE)

files2rm[!grepl(x = basename(files2rm), pattern = "^_index", ignore.case = TRUE)] |> 
  
  file.remove()

postDirs <- list.dirs(path = "static/manualsguides/", 
                      full.names = TRUE, recursive = FALSE)

for(i in seq_along(postDirs)){
  qmdFiles <- list.files(path = postDirs[i], pattern = "\\.qmd", 
                         full.names = TRUE, recursive = FALSE, ignore.case = TRUE)  
  
  for(j in seq_along(qmdFiles)){
    qmdFile <- readLines(con = qmdFiles[j])
    
    # Extract YAML text
    index <- grep(x = qmdFile, pattern = "^---$")[1:2]
    yaml <- yaml::read_yaml(text = paste(qmdFile[index[1]:index[2]], 
                                         collapse = "\n")) 
    
    # Define image path
    yaml$image <- file.path(dirname(qmdFiles[j]), yaml$image)
    
    if(is.null(yaml$image) || !file.exists(yaml$image)){
      yaml$image <- "images/no-image.webp"
    }
    
    yaml$image <- gsub(x = yaml$image, pattern = "^static/", replacement = "")
    
    # Define url field
    yaml$url <- file.path(paste0("/", basename(dirname(dirname(qmdFiles[j])))),
                          basename(dirname(qmdFiles[j])),
                          gsub(x = basename(qmdFiles[j]), 
                               pattern = "\\.qmd$", 
                               replacement = ".html", 
                               ignore.case = TRUE))
    
    outFile <- file.path("content/manualsguides/", 
                         paste(basename(dirname(qmdFiles[j])), 
                               gsub(x = basename(qmdFiles[j]), 
                                    pattern = "\\.qmd$", 
                                    replacement = ".md", 
                                    ignore.case = TRUE),
                               sep = "."))
    
    yaml[c("title", "description", "image", "date", "tags", "url")] |> 
      
      yaml::as.yaml() |> sprintf(fmt = "---\n%s\n---\n") |> 
      
      cat(file = outFile)
  }
}


