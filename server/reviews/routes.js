const { Router } = require('express');
const controller = require('./controller');

const router = Router();

router.get('/', controller.get10Reviews);
router.get("/:id", controller.getReviewById);
router.post('/', controller.addReview);
router.put('/:id/helpful', controller.markHelpful);
router.put('/:id/report', controller.markReport);
router.get('/meta/:id', controller.getMeta);

module.exports = router;