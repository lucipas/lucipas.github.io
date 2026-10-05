document.addEventListener("DOMContentLoaded", () => {
	if (typeof gsap === "undefined") return;

	// Always start at the top on refresh so the progress bar stays in sync
	if ("scrollRestoration" in history) {
		history.scrollRestoration = "manual";
	}
	window.scrollTo(0, 0);

	const hasPlugins =
		typeof ScrollTrigger !== "undefined" && typeof ScrollSmoother !== "undefined";
	let smoother = null;
	if (hasPlugins) {
		gsap.registerPlugin(ScrollTrigger, ScrollSmoother);
		smoother = ScrollSmoother.create({
			wrapper: "#smooth-wrapper",
			content: "#smooth-content",
			smooth: 2.2,
			effects: true,
		});
		smoother.scrollTop(0);
	}

	// Route nav clicks through ScrollSmoother so scrub stays in sync
	document.querySelectorAll('a[href^="#"]').forEach((a) => {
		a.addEventListener("click", (e) => {
			const target = document.querySelector(a.getAttribute("href"));
			if (!target) return;
			e.preventDefault();
			if (smoother) {
				smoother.scrollTo(target, 2, "top top");
			} else {
				target.scrollIntoView({ behavior: "smooth" });
			}
		});
	});

	// Hero entrance
	gsap.from(".hero > *", {
		y: 60,
		opacity: 0,
		duration: 1,
		stagger: 0.15,
		ease: "power3.out",
	});

const disp = document.querySelector("#wavy > feDisplacementMap");
const turb = document.querySelector("#wavy > feTurbulence");
const hero = document.querySelector(".hero");
const glow = document.querySelector("#glow > feFlood")

if (disp && turb && hero && !matchMedia("(prefers-reduced-motion: reduce)").matches) {
	hero.addEventListener("mousemove", (e) => {
		const r = hero.getBoundingClientRect();
		const nx = (e.clientX - r.left) / r.width;
		const ny = (e.clientY - r.top) / r.height;

		gsap.to(disp, {
			attr: { scale: 5 + nx * 35 },
			duration: 1.6, overwrite: "auto", ease: "power2.out"
		});
		gsap.to(turb, {
			attr: { baseFrequency: "0.2 0.3" },
			duration: 1.6, overwrite: "auto", ease: "power2.out"
		});
	});
	hero.addEventListener("mouseenter", (e)=> {

		gsap.to( glow, {
			attr: { "flood-opacity": 0.8},
			duration: 1.6,
			overwrite: "auto",
			ease: "power2.out"
		})
	})

	hero.addEventListener("mouseleave", () => {
		gsap.to(disp, { attr: { scale: 0 }, duration: 5, overwrite: "auto" });
		gsap.to(turb, { attr: { baseFrequency: "0.2 0.3" }, duration: 5 });
		gsap.to( glow, {
			attr: { "flood-opacity": 0.25},
			duration: 5,
			overwrite: "auto"
		})
	});
}



	// Scroll-driven tweens
	if (typeof ScrollTrigger !== "undefined") {
		gsap.to("body", {
			"--scroll": "#ff595e",
			"--prog-val": "#377ab0",
			ease: "none",
			scrollTrigger: {
				trigger: "#smooth-content",
				start: "top top",
				end: "bottom bottom",
				scrub: 1,
			},
		});

		gsap.to("#inv-wavy > feDisplacementMap", {
			attr: { scale: 0 },
			ease: "none",
			scrollTrigger: {
				trigger: ".hero",
				start: "top top",
				end: "bottom top",
				scrub: 1,
			},
		});

		// Section text scrubs in
		gsap.utils.toArray(".section p").forEach((p) => {
			gsap.from(p, {
				y: 30,
				opacity: 0,
				ease: "none",
				scrollTrigger: {
					trigger: p,
					start: "top 85%",
					end: "top 50%",
					scrub: 1,
				},
			});
		});

		// Nav slides in on first scroll
		gsap.to(".nav", {
			y: 0,
			opacity: 1,
			ease: "none",
			scrollTrigger: {
				trigger: "#smooth-content",
				start: "top top",
				end: "100px top",
				scrub: 1,
			},
		});

		gsap.utils.toArray(".section h2").forEach((h2) => {
			gsap.from(h2, {
				y: 50,
				opacity: 0,
				ease: "none",
				scrollTrigger: {
					trigger: h2,
					start: "top 85%",
					end: "top 40%",
					scrub: 1,
				},
			});
		});

		// Cards scrub in
		gsap.from(".card", {
			y: 60,
			opacity: 0,
			stagger: 0.15,
			ease: "none",
			scrollTrigger: {
				trigger: ".cards",
				start: "top 85%",
				end: "top 40%",
				scrub: 1,
			},
		});
	}
gsap.to("progress", {
  value: 100,
  ease: "none",
  scrollTrigger: {
    trigger: "#smooth-content",
    start: "top top",
    end: "bottom bottom",
    scrub: true
  }
});

	if (typeof ScrollTrigger !== "undefined") {
		window.addEventListener("load", () => ScrollTrigger.refresh());
	}
});
