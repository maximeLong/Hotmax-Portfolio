$(document).ready(function() {
    "use strict"
    if ($(".js-3dheader").length>0 && $(".js-3dheader").outerWidth() > 640) {
        var smallHeader = new SmallHeader($(".js-3dheader"));

    }
});

function SmallHeader(container) {
    "use strict"
    this.container = container;
    this.matrixValues = {
        "background": [
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1,
        ],
        "title": [
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1,
        ],
    }
    this.objectEvent = false;
    this.init();
    this.movingTarget;
}
SmallHeader.prototype = {
    constructor: SmallHeader,
    init: function() {
        this.addEvents();
        this.movingTarget = $(this.container).find(".small-header__background");
        console.log("init");
    },
    addEvents: function() {
        var self = this;
        if (this.objectEvent) {
            $(this.container).on("mousemove", function(e) {
                self.moveMouse(e.clientX, e.clientY);
            });
            $(this.container).on("mouseleave", function(e) {
                $(this).addClass("is-out");
                setTimeout(function() {
                    $(this).removeClass("is-out");
                }, 500)
                var wrapper = this.container.find(".small-header__wrapper");
                self.rotateAll(wrapper, self.matrixValues["title"], 0.01, 0.01, 0);
            });
        } else {
            $(window).on("mousemove", function(e) {
                self.moveMouse(e.clientX, e.clientY);
            });
        }
    },
    moveMouse: function(x, y) {
        if (this.objectEvent) {
            var targetOffsetX = $(this.movingTarget).offset().left;
            var targetOffsetY = $(this.movingTarget).offset().top;
            var targetWidth = $(this.movingTarget).outerWidth();
            var targetHeight = $(this.movingTarget).outerHeight();
            var centeredXPos = (x - targetOffsetX) - (targetWidth / 2);
            var centeredYPos = (y - targetOffsetY) - (targetHeight / 2);
        } else {
            var targetWidth = window.innerWidth;
            var targetHeight = window.innerHeight;
            var centeredXPos = x - (targetWidth / 2);
            var centeredYPos = y - (targetHeight / 2);
        }
        centeredXPos = centeredXPos.map(-(targetWidth / 2), targetWidth / 2, Math.PI, 2 * Math.PI);
        centeredYPos = centeredYPos.map(-(targetHeight / 2), targetHeight / 2, Math.PI, 2 * Math.PI);
        centeredXPos = Math.cos(centeredXPos);
        centeredYPos = Math.cos(centeredYPos);
        var wrapper = this.container.find(".small-header__wrapper");
        this.rotateAll(wrapper, this.matrixValues["title"], centeredYPos * 5, centeredXPos * 5, 0);
        //this.rotateAll($(this.movingTarget), this.matrixValues["background"],  centeredYPos*5,centeredXPos*5, 0);
    },
    translateTarget: function(target, matrix, x, y, z) {
        matrix[12] = x;
        matrix[13] = y;
        matrix[14] = z;
        matrix[15] = 1;
        this.applyTransform(target, matrix);
    },
    rotateAll: function(target, matrix, x, y, z) {
        x = x * Math.PI / 180;
        y = y * Math.PI / 180;
        z = z * Math.PI / 180;
        var sin = Math.sin;
        var cos = Math.cos;
        matrix[0] = cos(y) * cos(z);
        matrix[1] = -cos(y) * sin(z);
        matrix[2] = sin(y);
        matrix[3] = 0;
        matrix[4] = cos(x) * sin(z) + sin(x) * sin(y) * cos(z);
        matrix[5] = cos(x) * cos(z) - sin(x) * sin(y) * sin(z);
        matrix[6] = -sin(x) * cos(y);
        matrix[7] = 0;
        matrix[8] = sin(x) * sin(z) - cos(x) * sin(y) * cos(z);
        matrix[9] = sin(x) * cos(z) + cos(x) * sin(y) * sin(z);
        matrix[10] = cos(x) * cos(y);
        matrix[11] = 0;
        /*matrixValues[0] = (u*u+(v*v+w*w)*cos(a))/(u*u+v*v+w*w);
        matrixValues[1] = (u*v*(1-cos(a))-w*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[2] = (u*w*(1-cos(a))+u*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[3] = 0;
        matrixValues[4] = (u*w*(1-cos(a))+w*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[5] = (v*v+(u*u+w*w)*cos(a))/(u*u+v*v+w*w);
        matrixValues[6] = (v*w*(1-cos(a))-u*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[7] = 0;
        matrixValues[8] = (u*w*(1-cos(a))-v*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[9] = (u*w*(1-cos(a))+u*( Math.pow((u*u+v*v+w*w*sin(a)), 1/2))) /(u*u+v*v+w*w);
        matrixValues[10] = (w*w+(u*u+v*v)*cos(a))/(u*u+v*v+w*w);
        matrixValues[11] = 0;
        matrixValues[12] = 0;
        matrixValues[13] = 0;
        matrixValues[14] = 0;
        matrixValues[15] = 1;*/
        this.applyTransform(target, matrix);
    },
    rotateX: function(target, angle) {
        var radians = angle * Math.PI / 180;
        var sin = Math.sin;
        var cos = Math.cos;
        this.matrixValues[5] = cos(radians);
        this.matrixValues[6] = sin(radians);
        this.matrixValues[8] = sin(radians);
        this.matrixValues[9] = cos(radians);
        this.applyTransform(target);
    },
    rotateY: function(target, angle) {
        var radians = angle * Math.PI / 180;
        var sin = Math.sin;
        var cos = Math.cos;
        this.matrixValues[0] = cos(radians);
        this.matrixValues[2] = sin(radians);
        this.matrixValues[7] = -sin(radians);
        this.matrixValues[9] = cos(radians);
        this.applyTransform(target);
    },
    rotateZ: function(target, angle) {
        var radians = angle * Math.PI / 180;
        var sin = Math.sin;
        var cos = Math.cos;
        this.matrixValues[0] = cos(radians);
        this.matrixValues[1] = -sin(radians);
        this.matrixValues[4] = sin(radians);
        this.matrixValues[5] = cos(radians);
        this.applyTransform(target);
    },
    applyTransform: function(target, matrix) {
        var matrix3d = "matrix3d(" + matrix.toString() + ")";
        target.css({
            '-webkit-transform': matrix3d,
            '-moz-transform': matrix3d,
            '-ms-transform': matrix3d,
            '-o-transform': matrix3d,
            'transform': matrix3d
        });
    }
}
Number.prototype.map = function(in_min, in_max, out_min, out_max) {
    return (this - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
