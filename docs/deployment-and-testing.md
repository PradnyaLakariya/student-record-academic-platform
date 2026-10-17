# Deployment and Testing Notes

## API checks

| Check | Request | Expected result |
|---|---|---|
| Health | `GET /api/health` | HTTP 200 and `"status": "UP"` |
| Student list | `GET /api/students` | HTTP 200 and sample student records |
| Add student | `POST /api/students` | HTTP 201 for valid JSON |
| Add marks | `POST /api/marks` | HTTP 201 for an existing student and marks from 0 to 100 |
| Invalid marks | `POST /api/marks` with marks above 100 | HTTP 400 |

## Example requests

```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/students

curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{"name":"Isha Kulkarni","course":"CSE AIML","year":2}'

curl -X POST http://localhost:8080/api/marks \
  -H "Content-Type: application/json" \
  -d '{"student_id":1,"subject":"Statistics","marks":86}'
```

## Infrastructure checks

```bash
terraform -chdir=terraform validate
terraform -chdir=terraform plan
terraform -chdir=terraform output
ansible -i ansible/inventory.ini student_servers -m ping
ansible-playbook -i ansible/inventory.ini ansible/site.yml
```

## Notes and known limits

- Student and marks data is stored in process memory for a simple demonstration. Restarting the container resets records.
- The S3 bucket is provisioned as an infrastructure component; this starter does not yet upload database backups to it.
- Configure a key pair in the same region as the EC2 instance.
- Do not commit `terraform.tfstate`, `terraform.tfvars`, private keys, or AWS credentials.
