{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "cloudflare-speed-cli";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "kavehtehrani";
    repo = "cloudflare-speed-cli";
    rev = "v${version}";
    hash = "sha256-cskNER3GpBxZbORGnTsXL002VqDdkNos8dOovaThp78=";
  };

  cargoHash = "sha256-kOtcxOtSZ+iVJcUxr4fXeojsIK2gGmkAZRTXxU3VQMQ=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.Security
  ];

  meta = {
    description = "CLI for internet speed test via cloudflare";
    homepage = "https://github.com/kavehtehrani/cloudflare-speed-cli";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "cloudflare-speed-cli";
  };
}
