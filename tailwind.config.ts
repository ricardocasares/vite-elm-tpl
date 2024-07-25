import daisyui from "daisyui";
import { Config } from "tailwindcss";

export default {
  content: ["index.html", "src/**/*.elm"],
  plugins: [daisyui],
  daisyui: {
    themes: ["cmyk", "dracula"],
    darkTheme: "dracula",
  },
} satisfies Config;
