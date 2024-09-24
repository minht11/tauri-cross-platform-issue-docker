FROM rust:1.79

RUN apt-get install -y \
  curl

RUN curl -fsSL "https://deb.nodesource.com/setup_20.x" | bash - && \
    apt-get install -y nodejs
RUN corepack enable
RUN corepack prepare pnpm@latest --activate
RUN pnpm --version
RUN curl -fsSL https://get.pnpm.io/install.sh

RUN apt-get update && \
    apt-get install -y \
    libwebkit2gtk-4.1-dev \
    build-essential \
    curl \
    wget \
    file \
    libxdo-dev \
    libssl-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    nsis \
    lld \
    clang
    

RUN cargo install tauri-cli@2.0.0-rc.16 cargo-xwin --locked && \
    rustup target add x86_64-pc-windows-msvc

WORKDIR /app

COPY . .

RUN pnpm install

RUN cargo tauri build --runner cargo-xwin --target x86_64-pc-windows-msvc