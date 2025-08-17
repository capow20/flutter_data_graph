import { defineConfig } from "vite"

export default defineConfig(({command, mode}) => {
  return {
    publicDir: 'public',
    base: "./",
    build: {
      sourcemap: true,
      outDir: "../lib/src/js",
      minify: false,
      emptyOutDir: false,
      rollupOptions: {
        output: {
          entryFileNames: `[name].js`,
          chunkFileNames: `[name].js`,
          assetFileNames: `[name].[ext]`,
        },
      },
    }
  }
})
