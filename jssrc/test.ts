import * as hellolib from './main'

async function main() {
  for (let i = 0; i < 100000; i++) {
    let msg = `Hello ${i}` + '-'.repeat(i);
    console.log(`JS sending: ${msg}`);
    const response = hellolib.main.echo(msg)
    console.log(`JS response: ${response}`);
  }
}
main();
