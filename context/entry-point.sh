echo 'alias ll="ls -lahGF"' >> ~/.bashrc

XO_CONFIG_BASE="${HOME}/.config/xo-server"
XO_CONFIG_FILE="${XO_CONFIG_BASE}/config.toml"
mkdir -p ${XO_CONFIG_BASE}/


if [[ -s "${XO_CONFIG_FILE}" ]]; then
  cp -v /app/packages/xo-server/sample.config.toml "${XO_CONFIG_FILE}"
fi

if [[ -n "${XO_PORT}" ]]; then
  sed -i "s/^port = .*/port = ${XO_PORT}/g" "${XO_CONFIG_FILE}"
fi

cd /app/

yarn start