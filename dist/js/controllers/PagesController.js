(function() {
  define('controllers/PagesController', ['views/pages/main', 'views/pages/submit', 'views/pages/editr', 'views/pages/support', 'views/pages/how', 'views/pages/hire'], function(main, submit, editr, support, how, hire, terms) {
    var Controller;
    Controller = (function() {
      function Controller() {
        this.main = main;
        this.submit = submit;
        this.editr = editr;
        this.support = support;
        this.how = how;
        this.hire = hire;
      }

      return Controller;

    })();
    return new Controller;
  });

}).call(this);
