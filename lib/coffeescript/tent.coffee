#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

@Tent = {} unless @Tent?
@Tent.Controllers = Em.Namespace.create

require './util'
require './view'
require './controllers'
