{
  compartments = {
    "k3s" = "ocid1.compartment.oc1..aaaaaaaaid8ycvzzhbllf2zdnl52wwv0h1qgerlom2ygfkcsn7bbcsljjyuc"
    }
  k3s_ads = {
    "QjOL:EU-FRANKFURT-1-AD-1" = "ocid1.availabilitydomain.oc1..aaaaaaaats24q2ei96ttxnsmrybf0ti358slcbox4zy2l6ioj7vd3h60jqjk"
    "QjOL:EU-FRANKFURT-1-AD-2" = "ocid1.availabilitydomain.oc1..aaaaaaaa8zaqd18nakt5oj5jdq3faaf05n7l38q0bfp9zlv1ktekk4p1zept"
    "QjOL:EU-FRANKFURT-1-AD-3" = "ocid1.availabilitydomain.oc1..aaaaaaaa6t0csinjs9r5jw946u1bybg4vbk6amzdbdwsuhco2j8k8vj5offa"
  }
  oci_vcn_ad_subnets = {
    "QjOL:EU-FRANKFURT-1-AD-1" = {
      "display_name" = "k3s-eu-frankfurt-1-ad-1-subnet"
      "id" = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaa8l7w3smtepu7yw83udgsy2nlp8idwaxa8eceyy5yorhltjcqjrnx"
    }
    "QjOL:EU-FRANKFURT-1-AD-2" = {
      "display_name" = "k3s-eu-frankfurt-1-ad-2-subnet"
      "id" = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaart3ok2hvanqpcjwmbhy2a7b768emout9vh65hvflzowal1vnbhzs"
    }
    "QjOL:EU-FRANKFURT-1-AD-3" = {
      "display_name" = "k3s-eu-frankfurt-1-ad-3-subnet"
      "id" = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaavjailf8x13tzmozaggcpagtlasfib2qn68y05qs5q19hysk5tihc"
    }
  }
  oci_vcn_nsgs = {
    "permit_apiserver" = "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaaty98px5xw8ajggxzzgal79f3e5jx0t2oc0f0vyez0w10uf5g8r8t"
    "permit_ssh" = "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaavtteaqtztppr1to0y9jkmlawstk495fo6assej8ub1on1tf3i1t5"
    "permit_web" = "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaaxkvqmabwzqeb8mz7wz8w4n3t3qeslnal3pecu7olhdpdshl1tf33"
  }
  oci_vcn_regional_subnet = {
    "eu-frankfurt-1" = {
      "display_name" = "k3s-eu-frankfurt-1-regional-subnet"
      "id" = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaa3spjt4rzhq9mimr1dh2eg112ven9twi29px8m3eta4u6e9mfd6qs"
    }
  }
}
