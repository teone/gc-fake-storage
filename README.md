# Google Cloud Fake storage

This is a simple Dockerization of [fake-gcs-server](https://github.com/fsouza/fake-gcs-server) (many thanks to [@fsouza](https://github.com/fsouza/) for that).

## How to use

```shell
docker run -d --name gc-fake-storage -p 4443:4443 matteoscandolo/gc-fake-storage:0.1.0
```

## Preload data

In case you want to preload some data in `gs-fake-storage` just mount a folder in the container at `/data`:

```shell
docker run -d --name gc-fake-storage -p 4443:4443 -v /tmp/data:/data matteoscandolo/gc-fake-storage:0.1.0
```

Where the content of `/tmp/data` is:

```
- sample_bucket
  - some_file.txt
- another_bucket
  - some_other_file.txt
```

This will result in two `buckets` containing one `blob` each.

## Example with the `python` client library:

For a more complex example look into the `examples` directory

```python
from google.cloud import storage
from google.auth.credentials import AnonymousCredentials
import requests
import urllib3

storage._http.Connection.API_BASE_URL = "https://127.0.0.1:4443" # override the BASE_URL in the client library with the mock server

my_http = requests.Session()
my_http.verify = False  # disable SSL validation
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning) # disable https warnings for https insecure certs

client = storage.Client(credentials=AnonymousCredentials(), project="test", _http=my_http)
for bucket in client.list_buckets():
    print(bucket.name)
````
