module.exports = {
  files: {
    javascripts: {
      joinTo: "app.js"
    },
    stylesheets: {
      joinTo: "app.css"
    },
    templates: {
      joinTo: "app.js"
    }
  },

  plugins: {
    babel: {
      presets: ["es2015", "react"]
    },
    sass: {
      options: {
        includePaths: [
          "node_modules/tachyons-sass",
          "node_modules/animate.css",
          "node_modules/react-toastify/dist"
        ]
      }
    }
  },

  paths: {
    watched: ["app/frontend"],
    public: "public/assets"
  },

  conventions: {
    assets: /^(app\/frontend\/(images|fonts))/
  },

  npm: {
    globals: {
      $: "jquery",
      jQuery: "jquery",
      breakfast: "breakfast-rails"
    }
  }
};
