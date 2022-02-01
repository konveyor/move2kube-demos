const DEFAULT_PORT = 8080;
const argv = require('yargs')
  .strict()
  .scriptName("frontend")
  .usage('$0 [args]')
  .option('p', {alias: 'port', type: 'number', default: DEFAULT_PORT, describe: 'The port to listen on'})
  .option('g', {alias: 'gateway', type: 'string', default: 'gateway:8080', describe: 'The host/domain and port of the gateway service'})
  .help()
  .argv;

console.log(argv);

const path = require('path');
const express = require('express');
const app = express();
const port = argv.port || DEFAULT_PORT; // Use default port in case of NaN
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');
app.use(cors({
  'allowedHeaders': ['Content-Type'],
  'origin': '*',
  'preflightContinue': true
}));

const gateway_svc = `http://${argv.gateway}`;

let customerApiProxyOptions = {
  target: gateway_svc,
  changeOrigin: true,
  pathRewrite: {
    '^/customers-api': `/`,
  },
  logLevel: 'debug',
  secure: false,
};

const customerApiProxy = createProxyMiddleware(customerApiProxyOptions);

let orderApiProxyOptions = {
  target: gateway_svc,
  changeOrigin: true,
  pathRewrite: {
    '^/orders-api': `/`,
  },
  logLevel: 'debug',
  secure: false,
};

const ordersApiProxy = createProxyMiddleware(orderApiProxyOptions);

let cropsApiProxyOptions = {
  target: 'https://www.growstuff.org',
  changeOrigin: true,
  pathRewrite: {
    '^/crops-api': `/`,
  },
  logLevel: 'debug',
  secure: false,
};

const cropsApiProxy = createProxyMiddleware(cropsApiProxyOptions);

let productApiProxyOptions = {
  target: gateway_svc,
  changeOrigin: true,
  pathRewrite: {
    '^/products-api': `/`,
  },
  logLevel: 'debug',
  secure: false,
};

const productsApiProxy = createProxyMiddleware(productApiProxyOptions);

app.use(express.static(path.join(__dirname, '/dist')));

app.use('/products-api/', productsApiProxy);
app.use('/orders-api/', ordersApiProxy);
app.use('/customers-api/', customerApiProxy);
app.use('/crops-api/', cropsApiProxy);

app.get('*', (req, res) =>{
  res.sendFile(path.join(__dirname + '/dist/index.html'));
});

app.listen(port, () => console.log(`Listening on port ${port}`));
