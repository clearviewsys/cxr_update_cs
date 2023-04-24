//%attributes = {}
//https://developer.squareup.com/docs/checkout-api

// https://developer.squareup.com/docs/checkout-api/quick-pay-checkout

// going to use the quick pay option to create a payment link
// similare to POLI and PayMark in NZ/AU



SQ_getPaymentLink  // this create a link for the customer where they will pay via a square page

SQ_getOrderDetails  // this will get the order particulars based on the order_id retreived from sq_getPaymentLink

SQ_getPaymentDetails  // use the tender or payment id retreived from sq_getOrderDetails to get the payment objectisas

SQ_listener  // this listens for the webhook call from SQ - this must be configured for each "account" 
// 