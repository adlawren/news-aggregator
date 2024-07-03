// This is set using the "define" argument in the esbuild command, to toggle the API URL between development & production
// See package.json
const API_URL = process.env.REACT_API_URL;

export default API_URL;
