#' @export
get_property_tax_history <- function(property_ID){

  if (exists("jessionID") && nchar(jessionID) > 0) {
    headers <- c(
      'Accept' = '*/*',
      'Accept-Language' = 'en-US,en;q=0.7',
      'Connection' = 'keep-alive',
      'Content-Type' = 'application/json; charset=UTF-8',
      'Cookie' = paste0('JSESSIONID=', jessionID, '.server1'),
      'Origin' = 'https://panchatantra.karnataka.gov.in',
      'Referer' = 'https://panchatantra.karnataka.gov.in/USER_MODULE/userLogin/loadPanchamitra',
      'Sec-Fetch-Dest' = 'empty',
      'Sec-Fetch-Mode' = 'cors',
      'Sec-Fetch-Site' = 'same-origin',
      'Sec-GPC' = '1',
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'X-Requested-With' = 'XMLHttpRequest',
      'sec-ch-ua' = '"Brave";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile' = '?0',
      'sec-ch-ua-platform' = '"Windows"'
    )
  } else {
    print("Please provide a valid jessionID!")
  }

  bodz <- sprintf("{\"unique_id\":\"%s\",\"rec_type\":\"27\"}", property_ID)

  res <- VERB("POST", url = "https://bsk.karnataka.gov.in/BSK/ajax/getRDAPRWebService?serviceName=getReceiptsDetails&serviceType=MASTER", body = bodz, add_headers(headers))

  json_content <- content(res, "text", encoding = "UTF-8")
  dataf <- jsonlite::fromJSON(json_content) %>% as.data.frame() %>% clean_names()

  return(dataf)


}


#' @export
get_panchayat_details <- function(gp_ID){

  if (exists("jessionID") && nchar(jessionID) > 0) {
    headers <- c(
      'Accept' = '*/*',
      'Accept-Language' = 'en-US,en;q=0.7',
      'Connection' = 'keep-alive',
      'Content-Type' = 'application/json; charset=UTF-8',
      'Cookie' = paste0('JSESSIONID=', jessionID),
      'Origin' = 'https://panchatantra.karnataka.gov.in',
      'Referer' = 'https://panchatantra.karnataka.gov.in/USER_MODULE/userLogin/loadPanchamitra',
      'Sec-Fetch-Dest' = 'empty',
      'Sec-Fetch-Mode' = 'cors',
      'Sec-Fetch-Site' = 'same-origin',
      'Sec-GPC' = '1',
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'X-Requested-With' = 'XMLHttpRequest',
      'sec-ch-ua' = '"Brave";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile' = '?0',
      'sec-ch-ua-platform' = '"Windows"'
    )
  } else {
    print("Please provide a valid jessionID!")
  }




  bodzz = sprintf("{\"query_id\":\"20\",\"post_city\":\"%s\",\"access_level\":\"4\",\"language\":\"en\"}", gp_ID)

  res <- VERB("POST", url = "https://panchatantra.karnataka.gov.in/USER_MODULE/gpDashboard/getOperationWebService?serviceName=getCountByQueryIdForBeforeLoginForRevenue&serviceType=MASTER", body = bodzz, add_headers(headers))

  json_content <- content(res, "text", encoding = "UTF-8")
  gp_details <- jsonlite::fromJSON(json_content)
  gp_details <- fromJSON(gp_details$responseData)
  gp_details <- fromJSON(gp_details$sub_counts) %>% as.data.frame() %>% clean_names()
  gp_details$total_demand = as.numeric(gp_details$total_collected) + as.numeric(gp_details$total_balance)

  return(gp_details)


}

#' @export
get_property_panchayat_details <- function(property_ID){

  if (exists("jessionID") && nchar(jessionID) > 0) {
    headers <- c(
      'Accept' = '*/*',
      'Accept-Language' = 'en-US,en;q=0.7',
      'Connection' = 'keep-alive',
      'Content-Type' = 'application/json; charset=UTF-8',
      'Cookie' = paste0('JSESSIONID=', jessionID, '.server1'),
      'Origin' = 'https://panchatantra.karnataka.gov.in',
      'Referer' = 'https://panchatantra.karnataka.gov.in/USER_MODULE/userLogin/loadPanchamitra',
      'Sec-Fetch-Dest' = 'empty',
      'Sec-Fetch-Mode' = 'cors',
      'Sec-Fetch-Site' = 'same-origin',
      'Sec-GPC' = '1',
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'X-Requested-With' = 'XMLHttpRequest',
      'sec-ch-ua' = '"Brave";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile' = '?0',
      'sec-ch-ua-platform' = '"Windows"'
    )
  } else {
    print("Please provide a valid jessionID!")
  }

  dataf <- get_property_tax_history(property_ID)

  if (nrow(dataf) > 0) {
    # The dataframe has at least one row
    gp_ID <- dataf$receipt_number[1]

    # Extracting the text between the slashes
    gp_ID <- sub("^[^/]+/([^/]+)/.*$", "\\1", gp_ID)

    # Printing the result
    message("This is your GP: ", gp_ID, ". Now getting the GP details.")

    return(get_panchayat_details(gp_ID))


  } else {
    # The dataframe is empty
    print("no corresponding gp found, sorry!")
  }




}

