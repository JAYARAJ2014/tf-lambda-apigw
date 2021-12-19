// Lambda function code

module.exports.handler = async (event) => {
  console.log('Event: ', event);
  let responseMessage = 'Hello, World!';

  //If querystring parameter Name exists then say hello to that name. Else say hello world
  if (event.queryStringParameters && event.queryStringParameters['Name']) {
    responseMessage = 'Hello, ' + event.queryStringParameters['Name'];
  }
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      message: responseMessage,
    }),
  };
};
