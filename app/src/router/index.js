import Vue from 'vue'
import Router from 'vue-router'

import Vuex from 'vuex'
Vue.use(Vuex)
var store = require('../store/store')

// import Landing    from '@/views/v_landing'
// import About      from '@/views/v_about'
// import Contact    from '@/views/v_contact'
// import Services   from '@/views/v_services'
// import Work       from '@/views/v_work'

const Foo = { template: '<div>foo</div>' }

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Landing',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openLandingHub');
        next(vm => {}) //need to call next for router to continue to fire
      }
    },
    {
      path: '/services',
      name: 'Services',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openServicesOverlay', store.state.consoleTexts.ourServices);
        next(vm => {}) //need to call next for router to continue to fire
      }
    },
    {
      path: '/contact',
      name: 'Contact',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openServicesOverlay', store.state.consoleTexts.contactUs);
        next(vm => {}) //need to call next for router to continue to fire
      }

    },
    {
      path: '/about',
      name: 'About',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openServicesOverlay', store.state.consoleTexts.aboutUs);
        next(vm => {}) //need to call next for router to continue to fire
      }
    },
    {
      path: '/work/',
      name: 'Work',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openPortfolio');
        next(vm => {}) //need to call next for router to continue to fire
      }
    },
    {
      path: '/work/:work_id',
      name: 'Project',
      component: Foo,
      beforeEnter: (to, from, next) => {
        store.dispatch('openProjectWindow', store.state.projectWindows[to.params.work_id]);
        next(vm => {}) //need to call next for router to continue to fire
      }
    },
    {
      path: '/news/:news_id',
      name: 'News',
      component: Foo
    },
  ]
})
