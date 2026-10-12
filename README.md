# bigbaddomains
Big Bad Domains

Domain lists are maintained in `list/*.txt`, one domain per line.

Run `npm run build` to copy the category lists into `public/list/` and generate
the sorted combined list at `public/all.txt`. To use another output directory,
run `./scripts/build.sh <output-directory>`.

Run `npm test` to check the build, including failure handling.
