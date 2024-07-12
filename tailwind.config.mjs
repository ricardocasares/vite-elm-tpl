import daisyui from "daisyui";

export default {
  content: ["index.html", "src/**/*.{html,elm}"],
  plugins: [daisyui],
  daisyui: {
    themes: ["dracula", "black"],
  },
};
