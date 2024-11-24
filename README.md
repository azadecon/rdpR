# rdpR
a package to programmatically get a variety of data from Rural Development and Panchayat Raj Department, Government of Karnataka.

This package is currently in beta. Feedback, suggestions, and contributions are welcome-- feel free to open an issue or submit a pull request.

# How to install
```{R}
library(devtools)
```

```{R}
devtools::install_github("azadecon/rdpR")
```
# How to use this package?

Well, currently this is just a wrapper to get data from Bapuji Sewa Kendra ([BSK](https://bsk.karnataka.gov.in/BSK/cs/loadDownlodeReceipt)) and [Panchatantra](https://panchatantra.karnataka.gov.in/USER_MODULE/userLogin/loadHomePage). Several things are planned.

## get all the payment history for a `property_ID`
You can supply a `property_ID` and get the history of all the payments made, right in `R`.

```{R}
library(rdpr)
rdpr::get_property_tax_history("property_ID")

## example
## property_ID <- 150300700700400133
## property_ID <- 150300700700400095
```
This returns a dataframe containing the history of `n` payments in 5 columns and `n` rows. The columns are `receipt_number`, `payment_type`, `payment_amount`, `unique_id`, and `payment_date`.

`unique_id` is same as `"property_ID"`


## get the details of the respective panchayat for a `property_ID`
You can supply a `property_ID` and get the `total collection`, `total demand`, and `total balance`.


## get the details of the respective panchayat for a `gp_ID`
But if you know the  `gp_ID` (gram panchayat ID) and get the `total collection`, `total demand`, and `total balance`.
