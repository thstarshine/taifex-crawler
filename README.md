# taifex-crawler

## Update script

use crontab:

```
00 17 * * * bash /app/taifex-crawler/update.sh
```

## Filter script

give the product id to program:

```
bash filter.sh TX
```

output data will be gathered by year.

## Snippets

deal with 2011 time format:

```
sed -i 's/,\([0-9]\{6\}\)[0-9]\{2\}/,\1/g' file
```

remove product month:

```
sed -i 's/MTX ,[0-9]\+ ,/MTX ,/g' file
```

