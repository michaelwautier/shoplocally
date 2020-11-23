import "jquery-bar-rating";
import $ from 'jquery';


const initStarRating = () => {
  $('#shopreview_rating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };

