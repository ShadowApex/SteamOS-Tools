'use strict';

GetOption( { 'enhancement-market-ssa': false }, function( items )
{
	if( items[ 'enhancement-market-ssa' ] )
	{
		var element = document.getElementById( 'market_buynow_dialog_accept_ssa' );
 		
		if( element )
		{
			element.checked = true;
		}
		
		element = document.getElementById( 'market_sell_dialog_accept_ssa' );
		
		if( element )
		{
			element.checked = true;
		}
	}
} );
