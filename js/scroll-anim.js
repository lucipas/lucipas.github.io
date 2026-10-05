const canvas = document.getElementById("scrub");
const ctx = canvas.getContext("2d");

const FRAME_COUNT = 58;
const frames = [];
let loaded = 0;

let currentFrame = -1;

function setFrame(index) {
	const i = Math.round(index);
	if (i !== currentFrame) {
		currentFrame = i;
		draw();
	}
}

function sizeCanvas() {
	const dpr = window.devicePixelRatio || 1;
	canvas.width = window.innerWidth * dpr;
	canvas.height = window.innerHeight * dpr;
	ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
	draw();
}

function draw() {
	const img = frames[currentFrame];
	if (!img) return;
	ctx.clearRect(0, 0, window.innerWidth, window.innerHeight);
	// contain-fit the frame so the whole thing is visible
	const scale = Math.min(
		window.innerWidth / img.width,
		window.innerHeight / img.height
	);
	const w = img.width * scale;
	const h = img.height * scale;
	ctx.drawImage(img, (window.innerWidth - w) / 2, (window.innerHeight - h) / 2, w, h);
}

for (let i = 1; i <= FRAME_COUNT; i++) {
	const img = new Image();
	img.src = `frames/frame-${String(i).padStart(4, "0")}.png`;
	img.onload = () => {
		loaded++;
		if (loaded === FRAME_COUNT) {
			sizeCanvas();
			setFrame(0);
			initScroll();
		}
	};
	frames.push(img);
}

function initScroll() {
	gsap.registerPlugin(ScrollTrigger, ScrollSmoother);

	ScrollSmoother.create({
		wrapper: "#smooth-wrapper",
		content: "#smooth-content",
		smooth: 2,
		effects: true,
	});

	const state = { frame: 0 };
	gsap.to(state, {
		frame: FRAME_COUNT - 1,
		ease: "none",
		onUpdate: () => setFrame(state.frame),
		scrollTrigger: {
			trigger: "#spacer",
			start: "top top",
			end: "bottom bottom",
			scrub: 1,
		},
	});
}

window.addEventListener("resize", sizeCanvas);
