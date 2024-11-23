#' @export
get_property_tax_history <- function(property_ID){
  headers = c(
    'Accept' = '*/*',
    'Accept-Language' = 'en-US,en;q=0.6',
    'Connection' = 'keep-alive',
    'Content-Type' = 'application/json; charset=UTF-8',
    'Cookie' = 'JSESSIONID=BDAE6A54BD248CD2793D78BC3E695CB0.server1',
    'Origin' = 'https://bsk.karnataka.gov.in',
    'Referer' = 'https://bsk.karnataka.gov.in/BSK/cs/loadDownlodeReceipt',
    'Sec-Fetch-Dest' = 'empty',
    'Sec-Fetch-Mode' = 'cors',
    'Sec-Fetch-Site' = 'same-origin',
    'Sec-GPC' = '1',
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36',
    'X-Requested-With' = 'XMLHttpRequest',
    'sec-ch-ua' = '"Brave";v="129", "Not=A?Brand";v="8", "Chromium";v="129"',
    'sec-ch-ua-mobile' = '?0',
    'sec-ch-ua-platform' = '"Windows"'
  )

  bodz <- sprintf("{\"unique_id\":\"%s\",\"rec_type\":\"27\"}", property_ID)

  res <- VERB("POST", url = "https://bsk.karnataka.gov.in/BSK/ajax/getRDAPRWebService?serviceName=getReceiptsDetails&serviceType=MASTER", body = bodz, add_headers(headers))

  json_content <- content(res, "text")
  dataf <- jsonlite::fromJSON(json_content) %>% as.data.frame() %>% clean_names()

  return(dataf)


}
