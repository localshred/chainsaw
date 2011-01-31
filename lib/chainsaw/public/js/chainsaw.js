var Chainsaw = new Class({
  Binds: ['changeReport', 'reportSuccess', 'reportFailed'],
  Implements: [Events],
  
  initialize: function() {
    $$('#sidebar a').each(function(link) {
      alert('link '+link.get('title'));
      link.addEvent('click', this.changeReport);
    });
  },
  
  changeReport: function(evt) {
    alert('you clicked me!');
    // alert('got here');
    // evt.preventDefault();
    // $('report').find('.title').set('innerHTML', evt.target.getProperty('title'));
    // 
    // new Request({
    //   url: evt.target.get('href'),
    //   success: this.reportSuccess,
    //   failure: this.reportFailed
    // }).get();
  },
  
  reportSuccess: function(response) {
    alert('success!');
    // TODO add the report in
    // $('report').find('canvas')
  },
  
  reportFailed: function(error) {
    alert(error);
  }
});

window.addEvent('domready', function () {
	var chainsaw = new Chainsaw();
});