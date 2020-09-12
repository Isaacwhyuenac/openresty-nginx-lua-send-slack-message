--
-- Slack Verifying request filter
-- see: https://api.slack.com/docs/verifying-requests-from-slack
--
-- Setup:
--   cd /path/to/lua
--   curl -sL https://github.com/jkeys089/lua-resty-hmac/archive/master.tar.gz | tar zxf -
--
-- Usage:
--   ```nginx.conf
--     lua_package_path "/path/to/lua/lua-resty-hmac-master/lib/?.lua;;";
--     server {
--         location /lua {
--             set $slack_sigining_secret '{SLACK APP SIGNING SECRET}';
--             access_by_lua_file '/path/to/slack_verify_request.lua';
--             proxy_pass http://my-bot.domain/webhook;
--         }
--     }
--   ```
--

--
-- setup
--

local sigining_secret = ngx.var.slack_sigining_secret
if not sigining_secret or sigining_secret == '' then
    ngx.log(ngx.ERR, "Missing slack signing secret")
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

local hmac = require "resty.hmac"
local str = require "resty.string"

local function read_body()
  ngx.req.read_body()
  local body = ngx.req.get_body_data()
  if not body then
    local path = ngx.req.get_body_file()
    if not path then
      return nil
    end
    local fh = io.open(path, "r")
    if not fh then
      return nil
    end
    body = fh:read("*all")
    io.close(fh)
  end
  return body
end

local hmac_sha256 = hmac:new(sigining_secret, hmac.ALGOS.SHA256)
if not hmac_sha256 then
    ngx.log(ngx.ERR, "Failed to create the hmac_sha256 object")
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

--
-- verifying
--

timestamp = ngx.var.http_x_slack_request_timestamp
signature = ngx.var.http_x_slack_signature
body = read_body()

ngx.log(ngx.DEBUG, "timestamp=", timestamp, ", signature=", signature)

if (timestamp or '')  == '' or (signature or '') == '' then
    ngx.log(ngx.ERR, "Invalid Slack request: invalid header, timestamp=", timestamp, ", signature=", signature)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

if math.abs(ngx.now() - tonumber(timestamp)) > 60 * 5 then
    ngx.log(ngx.ERR, "Invalid Slack request: invalid timestamp, timestamp=", timestamp)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

hmac_sha256:update("v0:" .. timestamp .. ":" .. (body or ""))
local computed_signature = "v0=" .. str.to_hex(hmac_sha256:final())
ngx.log(ngx.DEBUG, "computed_signature=", computed_signature)

if signature ~= computed_signature then
    ngx.log(ngx.ERR, "Invalid Slack request: wrong signature, timestamp=", timestamp, ", signature=", computed_signature, "~=", signature)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end