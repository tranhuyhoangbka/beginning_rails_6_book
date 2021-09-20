import consumer from "./consumer"

consumer.subscriptions.create("ArticlesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if(data.new_article) {
      this.displayNewArticleNotification(data.new_article);
    }
  },

  displayNewArticleNotification(new_article) {
    const body = document.querySelector('body');
    body.insertAdjacentHTML('beforeend', new_article);
    const newArticleNotification = document.querySelector('#new-article-notification');
    setTimeout(() => {
      body.removeChild(newArticleNotification);
    }, 3000);
  }
});
