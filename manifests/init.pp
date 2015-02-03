# Copyright (C) 2015 Minted Inc.
# All Rights Reserved

class hub(
  $version = '2.2.0-rc1'
) {

  include hub::install
  include git
  include wget
  
}
