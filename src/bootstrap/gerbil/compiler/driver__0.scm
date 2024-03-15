(declare (block) (standard-bindings) (extended-bindings))
(begin
  (define gerbil/compiler/driver::timestamp 1710487497)
  (begin
    (define gxc#default-gerbil-gsc
      (path-expand '"gsc" (path-expand '"bin" (path-expand '"~~"))))
    (define gxc#default-gerbil-gcc '"gcc")
    (define gxc#default-gerbil-ar '"ar")
    (define gxc#+driver-mutex+ (make-mutex 'compiler/driver))
    (define gxc#compile-timestamp
      (lambda () (inexact->exact (floor (time->seconds (current-time))))))
    (define gxc#compile-timestamp-nanos
      (lambda () (time->seconds (current-time))))
    (define gxc#scheme-file-settings
      '(permissions: 420 char-encoding: UTF-8 eol-encoding: lf))
    (define gxc#with-output-to-scheme-file
      (lambda (_path158490_ _fun158491_)
        (with-output-to-file
         (let ((__tmp158584
                (let ()
                  (declare (not safe))
                  (cons _path158490_ gxc#scheme-file-settings))))
           (declare (not safe))
           (cons 'path: __tmp158584))
         _fun158491_)))
    (define gxc#+gerbil-gsc+ '#f)
    (define gxc#gerbil-gsc
      (lambda ()
        (if gxc#+gerbil-gsc+
            '#!void
            (set! gxc#+gerbil-gsc+
                  (getenv '"GERBIL_GSC" gxc#default-gerbil-gsc)))
        gxc#+gerbil-gsc+))
    (define gxc#+gerbil-gcc+ '#f)
    (define gxc#gerbil-gcc
      (lambda ()
        (if gxc#+gerbil-gcc+
            '#!void
            (set! gxc#+gerbil-gcc+
                  (getenv '"GERBIL_GCC" gxc#default-gerbil-gcc)))
        gxc#+gerbil-gcc+))
    (define gxc#+gerbil-ar+ '#f)
    (define gxc#gerbil-ar
      (lambda ()
        (if gxc#+gerbil-ar+
            '#!void
            (set! gxc#+gerbil-ar+ (getenv '"GERBIL_AR" gxc#default-gerbil-ar)))
        gxc#+gerbil-ar+))
    (define gxc#gerbil-rpath
      (lambda (_gerbil-libdir158485_)
        (string-append '"-Wl,-rpath=" _gerbil-libdir158485_)))
    (define gxc#gerbil-runtime-modules
      '("gerbil/runtime/gambit"
        "gerbil/runtime/util"
        "gerbil/runtime/table"
        "gerbil/runtime/control"
        "gerbil/runtime/system"
        "gerbil/runtime/c3"
        "gerbil/runtime/mop"
        "gerbil/runtime/error"
        "gerbil/runtime/interface"
        "gerbil/runtime/hash"
        "gerbil/runtime/thread"
        "gerbil/runtime/syntax"
        "gerbil/runtime/eval"
        "gerbil/runtime/repl"
        "gerbil/runtime/loader"
        "gerbil/runtime/init"
        "gerbil/runtime"))
    (define gxc#delete-directory*
      (lambda (_dir158483_) (delete-file-or-directory _dir158483_ '#t)))
    (define gxc#compile-module__%
      (lambda (_srcpath158457_ _opts158458_)
        (if (let () (declare (not safe)) (string? _srcpath158457_))
            '#!void
            (let ()
              (declare (not safe))
              (gxc#raise-compile-error
               '"Invalid module source path"
               _srcpath158457_)))
        (let ((_outdir158460_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'output-dir: _opts158458_)))
              (_invoke-gsc?158461_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'invoke-gsc: _opts158458_)))
              (_gsc-options158462_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'gsc-options: _opts158458_)))
              (_keep-scm?158463_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'keep-scm: _opts158458_)))
              (_verbosity158464_
               (let () (declare (not safe)) (pgetq__0 'verbose: _opts158458_)))
              (_optimize158465_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'optimize: _opts158458_)))
              (_debug158466_
               (let () (declare (not safe)) (pgetq__0 'debug: _opts158458_)))
              (_gen-ssxi158467_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'generate-ssxi: _opts158458_))))
          (if _outdir158460_
              (let ((__tmp158585
                     (lambda ()
                       (let ()
                         (declare (not safe))
                         (create-directory*__0 _outdir158460_)))))
                (declare (not safe))
                (with-lock gxc#+driver-mutex+ __tmp158585))
              '#!void)
          (if _optimize158465_
              (let ((__tmp158586
                     (lambda ()
                       (let ()
                         (declare (not safe))
                         (gxc#optimizer-info-init!)))))
                (declare (not safe))
                (with-lock gxc#+driver-mutex+ __tmp158586))
              '#!void)
          (let ((__tmp158590
                 (lambda ()
                   (let ()
                     (declare (not safe))
                     (gxc#verbose '"compile " _srcpath158457_))
                   (let ((__tmp158591
                          (let ((__tmp158592
                                 (lambda ()
                                   (let ()
                                     (declare (not safe))
                                     (gx#import-module__0 _srcpath158457_)))))
                            (declare (not safe))
                            (with-lock gxc#+driver-mutex+ __tmp158592))))
                     (declare (not safe))
                     (gxc#compile-top-module __tmp158591))))
                (__tmp158589
                 (let () (declare (not safe)) (gxc#compile-timestamp)))
                (__tmp158587
                 (let ((__tmp158588
                        (let ()
                          (declare (not safe))
                          (cons _srcpath158457_ '()))))
                   (declare (not safe))
                   (cons 'compile-module __tmp158588))))
            (declare (not safe))
            (call-with-parameters
             __tmp158590
             gxc#current-compile-output-dir
             _outdir158460_
             gxc#current-compile-invoke-gsc
             _invoke-gsc?158461_
             gxc#current-compile-gsc-options
             _gsc-options158462_
             gxc#current-compile-keep-scm
             _keep-scm?158463_
             gxc#current-compile-verbose
             _verbosity158464_
             gxc#current-compile-optimize
             _optimize158465_
             gxc#current-compile-debug
             _debug158466_
             gxc#current-compile-generate-ssxi
             _gen-ssxi158467_
             gxc#current-compile-timestamp
             __tmp158589
             gxc#current-compile-context
             __tmp158587
             gx#current-expander-compiling?
             '#t)))))
    (define gxc#compile-module__0
      (lambda (_srcpath158476_)
        (let ((_opts158478_ '()))
          (declare (not safe))
          (gxc#compile-module__% _srcpath158476_ _opts158478_))))
    (define gxc#compile-module
      (lambda _g158594_
        (let ((_g158593_ (let () (declare (not safe)) (##length _g158594_))))
          (cond ((let () (declare (not safe)) (##fx= _g158593_ 1))
                 (apply (lambda (_srcpath158476_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-module__0 _srcpath158476_)))
                        _g158594_))
                ((let () (declare (not safe)) (##fx= _g158593_ 2))
                 (apply (lambda (_srcpath158480_ _opts158481_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-module__%
                             _srcpath158480_
                             _opts158481_)))
                        _g158594_))
                (else
                 (##raise-wrong-number-of-arguments-exception
                  gxc#compile-module
                  _g158594_))))))
    (define gxc#compile-exe__%
      (lambda (_srcpath158433_ _opts158434_)
        (if (let () (declare (not safe)) (string? _srcpath158433_))
            '#!void
            (let ()
              (declare (not safe))
              (gxc#raise-compile-error
               '"Invalid module source path"
               _srcpath158433_)))
        (let ((_outdir158436_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'output-dir: _opts158434_)))
              (_invoke-gsc?158437_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'invoke-gsc: _opts158434_)))
              (_gsc-options158438_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'gsc-options: _opts158434_)))
              (_keep-scm?158439_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'keep-scm: _opts158434_)))
              (_verbosity158440_
               (let () (declare (not safe)) (pgetq__0 'verbose: _opts158434_)))
              (_debug158441_
               (let () (declare (not safe)) (pgetq__0 'debug: _opts158434_))))
          (if _outdir158436_
              (let ((__tmp158595
                     (lambda ()
                       (let ()
                         (declare (not safe))
                         (create-directory*__0 _outdir158436_)))))
                (declare (not safe))
                (with-lock gxc#+driver-mutex+ __tmp158595))
              '#!void)
          (let ((__tmp158599
                 (lambda ()
                   (let ()
                     (declare (not safe))
                     (gxc#verbose '"compile exe " _srcpath158433_))
                   (let ((__tmp158600
                          (let ((__tmp158601
                                 (lambda ()
                                   (let ()
                                     (declare (not safe))
                                     (gx#import-module__0 _srcpath158433_)))))
                            (declare (not safe))
                            (with-lock gxc#+driver-mutex+ __tmp158601))))
                     (declare (not safe))
                     (gxc#compile-executable-module
                      __tmp158600
                      _opts158434_))))
                (__tmp158598
                 (let () (declare (not safe)) (gxc#compile-timestamp)))
                (__tmp158596
                 (let ((__tmp158597
                        (let ()
                          (declare (not safe))
                          (cons _srcpath158433_ '()))))
                   (declare (not safe))
                   (cons 'compile-exe __tmp158597))))
            (declare (not safe))
            (call-with-parameters
             __tmp158599
             gxc#current-compile-output-dir
             _outdir158436_
             gxc#current-compile-invoke-gsc
             _invoke-gsc?158437_
             gxc#current-compile-gsc-options
             _gsc-options158438_
             gxc#current-compile-keep-scm
             _keep-scm?158439_
             gxc#current-compile-verbose
             _verbosity158440_
             gxc#current-compile-debug
             _debug158441_
             gxc#current-compile-timestamp
             __tmp158598
             gxc#current-compile-context
             __tmp158596
             gx#current-expander-compiling?
             '#t)))))
    (define gxc#compile-exe__0
      (lambda (_srcpath158449_)
        (let ((_opts158451_ '()))
          (declare (not safe))
          (gxc#compile-exe__% _srcpath158449_ _opts158451_))))
    (define gxc#compile-exe
      (lambda _g158603_
        (let ((_g158602_ (let () (declare (not safe)) (##length _g158603_))))
          (cond ((let () (declare (not safe)) (##fx= _g158602_ 1))
                 (apply (lambda (_srcpath158449_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-exe__0 _srcpath158449_)))
                        _g158603_))
                ((let () (declare (not safe)) (##fx= _g158602_ 2))
                 (apply (lambda (_srcpath158453_ _opts158454_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-exe__% _srcpath158453_ _opts158454_)))
                        _g158603_))
                (else
                 (##raise-wrong-number-of-arguments-exception
                  gxc#compile-exe
                  _g158603_))))))
    (define gxc#compile-executable-module
      (lambda (_ctx158429_ _opts158430_)
        (if (let ()
              (declare (not safe))
              (pgetq__0 'full-program-optimization: _opts158430_))
            (let ()
              (declare (not safe))
              (gxc#compile-executable-module/full-program-optimization
               _ctx158429_
               _opts158430_))
            (let ()
              (declare (not safe))
              (gxc#compile-executable-module/separate
               _ctx158429_
               _opts158430_)))))
    (define gxc#compile-executable-module/separate
      (lambda (_ctx158311_ _opts158312_)
        (letrec ((_generate-stub158314_
                  (lambda (_linker158422_ _builtin-modules158423_)
                    (let ((_mod-main158425_
                           (let ()
                             (declare (not safe))
                             (gxc#find-runtime-symbol _ctx158311_ 'main))))
                      (for-each
                       (lambda (_mod158427_)
                         (write (let ((__tmp158604
                                       (let ()
                                         (declare (not safe))
                                         (cons _mod158427_ '()))))
                                  (declare (not safe))
                                  (cons '##supply-module __tmp158604)))
                         (newline))
                       _builtin-modules158423_)
                      (write (let ((__tmp158605
                                    (let ()
                                      (declare (not safe))
                                      (cons _linker158422_ '()))))
                               (declare (not safe))
                               (cons '##supply-module __tmp158605)))
                      (newline)
                      (write (let ((__tmp158606
                                    (let ((__tmp158607
                                           (let ((__tmp158608
                                                  (let ((__tmp158609
                                                         (let ((__tmp158611
                                                                (let ((__tmp158612
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (let ()
                                 (declare (not safe))
                                 (cons _builtin-modules158423_ '()))))
                          (declare (not safe))
                          (cons 'quote __tmp158612)))
                       (__tmp158610
                        (let ()
                          (declare (not safe))
                          (cons 'libgerbil-builtin-modules '()))))
                   (declare (not safe))
                   (cons __tmp158611 __tmp158610))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons 'append
                                                          __tmp158609))))
                                             (declare (not safe))
                                             (cons __tmp158608 '()))))
                                      (declare (not safe))
                                      (cons 'builtin-modules __tmp158607))))
                               (declare (not safe))
                               (cons 'define __tmp158606)))
                      (newline)
                      (write (let ((__tmp158613
                                    (let ((__tmp158652
                                           (let ()
                                             (declare (not safe))
                                             (cons 'gerbil-main '())))
                                          (__tmp158614
                                           (let ((__tmp158615
                                                  (let ((__tmp158616
                                                         (let ((__tmp158640
                                                                (let ((__tmp158641
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (let ((__tmp158642
                                      (let ((__tmp158650
                                             (let ((__tmp158651
                                                    (let ()
                                                      (declare (not safe))
                                                      (cons 'builtin-modules
                                                            '()))))
                                               (declare (not safe))
                                               (cons 'gerbil-runtime-init!
                                                     __tmp158651)))
                                            (__tmp158643
                                             (let ((__tmp158644
                                                    (let ((__tmp158645
                                                           (let ((__tmp158646
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (let ((__tmp158647
                                 (let ((__tmp158648
                                        (let ((__tmp158649
                                               (let ()
                                                 (declare (not safe))
                                                 (cons 'command-line '()))))
                                          (declare (not safe))
                                          (cons __tmp158649 '()))))
                                   (declare (not safe))
                                   (cons 'cdr __tmp158648))))
                            (declare (not safe))
                            (cons __tmp158647 '()))))
                     (declare (not safe))
                     (cons _mod-main158425_ __tmp158646))))
              (declare (not safe))
              (cons 'apply __tmp158645))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                               (declare (not safe))
                                               (cons __tmp158644 '()))))
                                        (declare (not safe))
                                        (cons __tmp158650 __tmp158643))))
                                 (declare (not safe))
                                 (cons '() __tmp158642))))
                          (declare (not safe))
                          (cons 'lambda __tmp158641)))
                       (__tmp158617
                        (let ((__tmp158618
                               (let ((__tmp158619
                                      (let ((__tmp158620
                                             (let ((__tmp158631
                                                    (let ((__tmp158632
                                                           (let ((__tmp158633
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (let ((__tmp158634
                                 (let ((__tmp158635
                                        (let ((__tmp158636
                                               (let ((__tmp158637
                                                      (let ((__tmp158638
                                                             (let ((__tmp158639
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                            (let ()
                              (declare (not safe))
                              (cons 'current-output-port '()))))
                       (declare (not safe))
                       (cons __tmp158639 '()))))
                (declare (not safe))
                (cons 'force-output __tmp158638))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                 (declare (not safe))
                                                 (cons __tmp158637 '()))))
                                          (declare (not safe))
                                          (cons '() __tmp158636))))
                                   (declare (not safe))
                                   (cons 'lambda __tmp158635))))
                            (declare (not safe))
                            (cons __tmp158634 '()))))
                     (declare (not safe))
                     (cons 'void __tmp158633))))
              (declare (not safe))
              (cons 'with-catch __tmp158632)))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (__tmp158621
                                                    (let ((__tmp158622
                                                           (let ((__tmp158623
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (let ((__tmp158624
                                 (let ((__tmp158625
                                        (let ((__tmp158626
                                               (let ((__tmp158627
                                                      (let ((__tmp158628
                                                             (let ((__tmp158629
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                            (let ((__tmp158630
                                   (let ()
                                     (declare (not safe))
                                     (cons 'current-error-port '()))))
                              (declare (not safe))
                              (cons __tmp158630 '()))))
                       (declare (not safe))
                       (cons 'force-output __tmp158629))))
                (declare (not safe))
                (cons __tmp158628 '()))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                 (declare (not safe))
                                                 (cons '() __tmp158627))))
                                          (declare (not safe))
                                          (cons 'lambda __tmp158626))))
                                   (declare (not safe))
                                   (cons __tmp158625 '()))))
                            (declare (not safe))
                            (cons 'void __tmp158624))))
                     (declare (not safe))
                     (cons 'with-catch __tmp158623))))
              (declare (not safe))
              (cons __tmp158622 '()))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                               (declare (not safe))
                                               (cons __tmp158631
                                                     __tmp158621))))
                                        (declare (not safe))
                                        (cons '() __tmp158620))))
                                 (declare (not safe))
                                 (cons 'lambda __tmp158619))))
                          (declare (not safe))
                          (cons __tmp158618 '()))))
                   (declare (not safe))
                   (cons __tmp158640 __tmp158617))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons 'with-unwind-protect
                                                          __tmp158616))))
                                             (declare (not safe))
                                             (cons __tmp158615 '()))))
                                      (declare (not safe))
                                      (cons __tmp158652 __tmp158614))))
                               (declare (not safe))
                               (cons 'define __tmp158613)))
                      (newline)
                      (write '(gerbil-main))
                      (newline))))
                 (_get-libgerbil-ld-opts158315_
                  (lambda (_libgerbil158420_)
                    (call-with-input-file
                     (string-append _libgerbil158420_ '".ldd")
                     read)))
                 (_replace-extension158316_
                  (lambda (_path158417_ _ext158418_)
                    (string-append
                     (path-strip-extension _path158417_)
                     _ext158418_)))
                 (_not-exclude-module?158317_
                  (lambda (_ctx158413_)
                    (let ((_id-str158415_
                           (symbol->string
                            (##structure-ref
                             _ctx158413_
                             '1
                             gx#expander-context::t
                             '#f))))
                      (if (let ((__tmp158654
                                 (let ()
                                   (declare (not safe))
                                   (string-prefix?
                                    '"gerbil/"
                                    _id-str158415_))))
                            (declare (not safe))
                            (not __tmp158654))
                          (let ((__tmp158653
                                 (let ()
                                   (declare (not safe))
                                   (string-prefix? '"std/" _id-str158415_))))
                            (declare (not safe))
                            (not __tmp158653))
                          '#f))))
                 (_not-file-empty?158318_
                  (lambda (_path158411_)
                    (let ((__tmp158655
                           (let ()
                             (declare (not safe))
                             (gxc#file-empty? _path158411_))))
                      (declare (not safe))
                      (not __tmp158655))))
                 (_compile-stub158319_
                  (lambda (_output-scm158326_ _output-bin158327_)
                    (let* ((_gerbil-home158329_
                            (getenv '"GERBIL_BUILD_PREFIX"
                                    (let ()
                                      (declare (not safe))
                                      (gerbil-home))))
                           (_gerbil-libdir158331_
                            (path-expand '"lib" _gerbil-home158329_))
                           (_gerbil-staticdir158333_
                            (path-expand '"static" _gerbil-libdir158331_))
                           (_gxlink158335_
                            (path-expand
                             '"libgerbil-link"
                             _gerbil-libdir158331_))
                           (_tmp158337_
                            (path-expand
                             (string-append
                              '"gxc."
                              (number->string
                               (let ()
                                 (declare (not safe))
                                 (gxc#compile-timestamp-nanos))))
                             '"/tmp"))
                           (_tmp-path158341_
                            (lambda (_f158339_)
                              (path-expand
                               (path-strip-directory _f158339_)
                               _tmp158337_)))
                           (_deps158343_
                            (let ()
                              (declare (not safe))
                              (gxc#find-runtime-module-deps _ctx158311_)))
                           (_deps158345_
                            (filter _not-exclude-module?158317_ _deps158343_))
                           (_src-deps-scm158347_
                            (map gxc#find-static-module-file _deps158345_))
                           (_src-deps-scm158349_
                            (filter _not-file-empty?158318_
                                    _src-deps-scm158347_))
                           (_src-deps-scm158351_
                            (map path-expand _src-deps-scm158349_))
                           (_deps-scm158353_
                            (map _tmp-path158341_ _src-deps-scm158351_))
                           (_deps-c158359_
                            (map (lambda (_g158354158356_)
                                   (let ()
                                     (declare (not safe))
                                     (_replace-extension158316_
                                      _g158354158356_
                                      '".c")))
                                 _deps-scm158353_))
                           (_deps-o158365_
                            (map (lambda (_g158360158362_)
                                   (let ()
                                     (declare (not safe))
                                     (_replace-extension158316_
                                      _g158360158362_
                                      '".o")))
                                 _deps-scm158353_))
                           (_src-bin-scm158367_
                            (let ()
                              (declare (not safe))
                              (gxc#find-static-module-file _ctx158311_)))
                           (_src-bin-scm158369_
                            (path-expand _src-bin-scm158367_))
                           (_bin-scm158371_
                            (let ()
                              (declare (not safe))
                              (_tmp-path158341_ _src-bin-scm158369_)))
                           (_bin-c158373_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _bin-scm158371_
                               '".c")))
                           (_bin-o158375_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _bin-scm158371_
                               '".o")))
                           (_output-bin158377_
                            (path-expand _output-bin158327_))
                           (_output-scm158379_
                            (path-expand _output-scm158326_))
                           (_output-c158381_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _output-scm158379_
                               '".c")))
                           (_output-o158383_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _output-scm158379_
                               '".o")))
                           (_output_-c158385_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _output-scm158379_
                               '"_.c")))
                           (_output_-o158387_
                            (let ()
                              (declare (not safe))
                              (_replace-extension158316_
                               _output-scm158379_
                               '"_.o")))
                           (_gsc-link-opts158389_
                            (let ()
                              (declare (not safe))
                              (gxc#gsc-link-options__0)))
                           (_gsc-cc-opts158391_
                            (let ()
                              (declare (not safe))
                              (gxc#gsc-cc-options__0)))
                           (_gsc-static-opts158393_
                            (let ()
                              (declare (not safe))
                              (gxc#gsc-static-include-options
                               _gerbil-staticdir158333_)))
                           (_output-ld-opts158395_
                            (let () (declare (not safe)) (gxc#gcc-ld-options)))
                           (_libgerbil.a158397_
                            (path-expand '"libgerbil.a" _gerbil-libdir158331_))
                           (_libgerbil.so158399_
                            (path-expand
                             '"libgerbil.so"
                             _gerbil-libdir158331_))
                           (_libgerbil-ld-opts158401_
                            (if (file-exists? _libgerbil.so158399_)
                                (let ()
                                  (declare (not safe))
                                  (_get-libgerbil-ld-opts158315_
                                   _libgerbil.so158399_))
                                (if (file-exists? _libgerbil.a158397_)
                                    (let ()
                                      (declare (not safe))
                                      (_get-libgerbil-ld-opts158315_
                                       _libgerbil.a158397_))
                                    (let ()
                                      (declare (not safe))
                                      (gxc#raise-compile-error
                                       '"libgerbil does not exist"
                                       _libgerbil.a158397_
                                       _libgerbil.so158399_)))))
                           (_rpath158403_
                            (let ()
                              (declare (not safe))
                              (gxc#gerbil-rpath _gerbil-libdir158331_)))
                           (_builtin-modules158405_
                            (map gx#expander-context-id
                                 (let ()
                                   (declare (not safe))
                                   (cons _ctx158311_ _deps158345_)))))
                      (let ((__tmp158656
                             (lambda ()
                               (let ((__tmp158657
                                      (path-directory _output-bin158377_)))
                                 (declare (not safe))
                                 (create-directory*__0 __tmp158657)))))
                        (declare (not safe))
                        (with-lock gxc#+driver-mutex+ __tmp158656))
                      (let ((__tmp158658
                             (lambda ()
                               (let ((__tmp158659
                                      (string->symbol
                                       (path-strip-extension
                                        (path-strip-directory
                                         _output-scm158379_)))))
                                 (declare (not safe))
                                 (_generate-stub158314_
                                  __tmp158659
                                  _builtin-modules158405_)))))
                        (declare (not safe))
                        (gxc#with-output-to-scheme-file
                         _output-scm158379_
                         __tmp158658))
                      (if (gxc#current-compile-invoke-gsc)
                          (begin
                            (let ((__tmp158660
                                   (lambda () (create-directory _tmp158337_))))
                              (declare (not safe))
                              (with-lock gxc#+driver-mutex+ __tmp158660))
                            (for-each
                             copy-file
                             _src-deps-scm158351_
                             _deps-scm158353_)
                            (copy-file _src-bin-scm158369_ _bin-scm158371_)
                            (let ((__tmp158668
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gsc)))
                                  (__tmp158661
                                   (let ((__tmp158662
                                          (let ((__tmp158663
                                                 (let ((__tmp158664
                                                        (let ((__tmp158665
                                                               (let ((__tmp158666
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              (let ((__tmp158667
                                     (let ()
                                       (declare (not safe))
                                       (cons _output-scm158379_ '()))))
                                (declare (not safe))
                                (cons _bin-scm158371_ __tmp158667))))
                         (declare (not safe))
                         (foldr1 cons __tmp158666 _deps-scm158353_))))
                  (declare (not safe))
                  (foldr1 cons __tmp158665 _gsc-link-opts158389_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (cons _gxlink158335_
                                                         __tmp158664))))
                                            (declare (not safe))
                                            (cons '"-l" __tmp158663))))
                                     (declare (not safe))
                                     (cons '"-link" __tmp158662))))
                              (declare (not safe))
                              (gxc#invoke __tmp158668 __tmp158661))
                            (let ((__tmp158676
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gsc)))
                                  (__tmp158669
                                   (let ((__tmp158670
                                          (let ((__tmp158671
                                                 (let ((__tmp158672
                                                        (let ((__tmp158673
                                                               (let ((__tmp158674
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              (let ((__tmp158675
                                     (let ()
                                       (declare (not safe))
                                       (cons _output_-c158385_ '()))))
                                (declare (not safe))
                                (cons _output-c158381_ __tmp158675))))
                         (declare (not safe))
                         (cons _bin-c158373_ __tmp158674))))
                  (declare (not safe))
                  (foldr1 cons __tmp158673 _deps-c158359_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (foldr1 cons
                                                           __tmp158672
                                                           _gsc-static-opts158393_))))
                                            (declare (not safe))
                                            (foldr1 cons
                                                    __tmp158671
                                                    _gsc-cc-opts158391_))))
                                     (declare (not safe))
                                     (cons '"-obj" __tmp158670))))
                              (declare (not safe))
                              (gxc#invoke __tmp158676 __tmp158669))
                            (let ((__tmp158689
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gcc)))
                                  (__tmp158677
                                   (let ((__tmp158678
                                          (let ((__tmp158679
                                                 (let ((__tmp158680
                                                        (let ((__tmp158681
                                                               (let ((__tmp158682
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              (let ((__tmp158683
                                     (let ((__tmp158684
                                            (let ((__tmp158685
                                                   (let ((__tmp158686
                                                          (let ((__tmp158687
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                         (let ((__tmp158688
                                (let ()
                                  (declare (not safe))
                                  (cons '"-lgambit"
                                        _libgerbil-ld-opts158401_))))
                           (declare (not safe))
                           (cons '"-lgerbil" __tmp158688))))
                    (declare (not safe))
                    (cons _gerbil-libdir158331_ __tmp158687))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                     (declare (not safe))
                                                     (cons '"-L"
                                                           __tmp158686))))
                                              (declare (not safe))
                                              (cons _rpath158403_
                                                    __tmp158685))))
                                       (declare (not safe))
                                       (foldr1 cons
                                               __tmp158684
                                               _output-ld-opts158395_))))
                                (declare (not safe))
                                (cons _output_-o158387_ __tmp158683))))
                         (declare (not safe))
                         (cons _output-o158383_ __tmp158682))))
                  (declare (not safe))
                  (cons _bin-o158375_ __tmp158681))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (foldr1 cons
                                                           __tmp158680
                                                           _deps-o158365_))))
                                            (declare (not safe))
                                            (cons _output-bin158377_
                                                  __tmp158679))))
                                     (declare (not safe))
                                     (cons '"-o" __tmp158678))))
                              (declare (not safe))
                              (gxc#invoke __tmp158689 __tmp158677))
                            (for-each
                             delete-file
                             (let ((__tmp158690
                                    (let ((__tmp158691
                                           (let ((__tmp158692
                                                  (let ()
                                                    (declare (not safe))
                                                    (cons _output_-o158387_
                                                          '()))))
                                             (declare (not safe))
                                             (cons _output-o158383_
                                                   __tmp158692))))
                                      (declare (not safe))
                                      (cons _output_-c158385_ __tmp158691))))
                               (declare (not safe))
                               (cons _output-c158381_ __tmp158690)))
                            (let ()
                              (declare (not safe))
                              (gxc#delete-directory* _tmp158337_)))
                          '#!void)))))
          (let* ((_output-bin158321_
                  (let ()
                    (declare (not safe))
                    (gxc#compile-exe-output-file _ctx158311_ _opts158312_)))
                 (_output-scm158323_
                  (string-append _output-bin158321_ '"__exe.scm")))
            (let ()
              (declare (not safe))
              (_compile-stub158319_ _output-scm158323_ _output-bin158321_))
            (if (gxc#current-compile-keep-scm)
                '#!void
                (delete-file _output-scm158323_))))))
    (define gxc#compile-executable-module/full-program-optimization
      (lambda (_ctx158136_ _opts158137_)
        (letrec ((_reset-declare158139_
                  (lambda ()
                    '(declare
                       (gambit-scheme)
                       (block)
                       (core)
                       (inline)
                       (inline-primitives)
                       (inlining-limit 350)
                       (constant-fold)
                       (lambda-lift)
                       (standard-bindings)
                       (extended-bindings)
                       (run-time-bindings)
                       (safe)
                       (interrupts-enabled)
                       (proper-tail-calls)
                       (not generative-lambda)
                       (optimize-dead-local-variables)
                       (optimize-dead-definitions)
                       (generic)
                       (mostly-fixnum-flonum))))
                 (_generate-stub158140_
                  (lambda (_deps158302_)
                    (let ((_mod-main158304_
                           (let ()
                             (declare (not safe))
                             (gxc#find-runtime-symbol _ctx158136_ 'main)))
                          (_reset-decl158305_
                           (let ()
                             (declare (not safe))
                             (_reset-declare158139_)))
                          (_user-decl158306_
                           (let ()
                             (declare (not safe))
                             (_user-declare158141_))))
                      (for-each
                       (lambda (_dep158308_)
                         (write '(##namespace ("")))
                         (newline)
                         (write _reset-decl158305_)
                         (newline)
                         (if _user-decl158306_
                             (begin (write _user-decl158306_) (newline))
                             '#!void)
                         (write (let ((__tmp158693
                                       (let ()
                                         (declare (not safe))
                                         (cons _dep158308_ '()))))
                                  (declare (not safe))
                                  (cons 'include __tmp158693)))
                         (newline))
                       _deps158302_)
                      (write (let ((__tmp158694
                                    (let ((__tmp158707
                                           (let ()
                                             (declare (not safe))
                                             (cons 'gerbil-main '())))
                                          (__tmp158695
                                           (let ((__tmp158703
                                                  (let ((__tmp158704
                                                         (let ((__tmp158705
                                                                (let ((__tmp158706
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (let () (declare (not safe)) (cons '() '()))))
                          (declare (not safe))
                          (cons 'quote __tmp158706))))
                   (declare (not safe))
                   (cons __tmp158705 '()))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons 'gerbil-runtime-init!
                                                          __tmp158704)))
                                                 (__tmp158696
                                                  (let ((__tmp158697
                                                         (let ((__tmp158698
                                                                (let ((__tmp158699
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (let ((__tmp158700
                                      (let ((__tmp158701
                                             (let ((__tmp158702
                                                    (let ()
                                                      (declare (not safe))
                                                      (cons 'command-line
                                                            '()))))
                                               (declare (not safe))
                                               (cons __tmp158702 '()))))
                                        (declare (not safe))
                                        (cons 'cdr __tmp158701))))
                                 (declare (not safe))
                                 (cons __tmp158700 '()))))
                          (declare (not safe))
                          (cons _mod-main158304_ __tmp158699))))
                   (declare (not safe))
                   (cons 'apply __tmp158698))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons __tmp158697 '()))))
                                             (declare (not safe))
                                             (cons __tmp158703 __tmp158696))))
                                      (declare (not safe))
                                      (cons __tmp158707 __tmp158695))))
                               (declare (not safe))
                               (cons 'define __tmp158694)))
                      (write '(gerbil-main))
                      (newline))))
                 (_user-declare158141_
                  (lambda ()
                    (let* ((_gsc-opts158207_
                            (let ()
                              (declare (not safe))
                              (pgetq__0 'gsc-options: _opts158137_)))
                           (_gsc-prelude158209_
                            (if _gsc-opts158207_
                                (member '"-prelude" _gsc-opts158207_)
                                '#f))
                           (_gsc-prelude158211_
                            (if _gsc-prelude158209_
                                (read (open-input-string
                                       (cadr _gsc-prelude158209_)))
                                '#f)))
                      (let _lp158214_ ((_rest158216_
                                        (let ()
                                          (declare (not safe))
                                          (cons _gsc-prelude158211_ '())))
                                       (_user-decls158217_ '()))
                        (let* ((_rest158218158226_ _rest158216_)
                               (_else158220158234_
                                (lambda ()
                                  (if (let ()
                                        (declare (not safe))
                                        (null? _user-decls158217_))
                                      '#f
                                      (let ((__tmp158708
                                             (reverse _user-decls158217_)))
                                        (declare (not safe))
                                        (cons 'declare __tmp158708)))))
                               (_K158222158290_
                                (lambda (_rest158237_ _expr158238_)
                                  (let* ((_expr158239158251_ _expr158238_)
                                         (_else158242158259_
                                          (lambda ()
                                            (let ()
                                              (declare (not safe))
                                              (_lp158214_
                                               _rest158237_
                                               _user-decls158217_)))))
                                    (let ((_K158247158280_
                                           (lambda (_decls158278_)
                                             (let ((__tmp158709
                                                    (let ()
                                                      (declare (not safe))
                                                      (foldl1 cons
                                                              _user-decls158217_
                                                              _decls158278_))))
                                               (declare (not safe))
                                               (_lp158214_
                                                _rest158237_
                                                __tmp158709))))
                                          (_K158244158265_
                                           (lambda (_exprs158263_)
                                             (let ((__tmp158710
                                                    (append _exprs158263_
                                                            _rest158237_)))
                                               (declare (not safe))
                                               (_lp158214_
                                                __tmp158710
                                                _user-decls158217_)))))
                                      (if (let ()
                                            (declare (not safe))
                                            (##pair? _expr158239158251_))
                                          (let ((_tl158249158285_
                                                 (let ()
                                                   (declare (not safe))
                                                   (##cdr _expr158239158251_)))
                                                (_hd158248158283_
                                                 (let ()
                                                   (declare (not safe))
                                                   (##car _expr158239158251_))))
                                            (if (let ()
                                                  (declare (not safe))
                                                  (##eq? _hd158248158283_
                                                         'declare))
                                                (let ((_decls158288_
                                                       _tl158249158285_))
                                                  (declare (not safe))
                                                  (_K158247158280_
                                                   _decls158288_))
                                                (if (let ()
                                                      (declare (not safe))
                                                      (##eq? _hd158248158283_
                                                             'begin))
                                                    (let ((_exprs158273_
                                                           _tl158249158285_))
                                                      (declare (not safe))
                                                      (_K158244158265_
                                                       _exprs158273_))
                                                    (let ()
                                                      (declare (not safe))
                                                      (_else158242158259_)))))
                                          (let ()
                                            (declare (not safe))
                                            (_else158242158259_))))))))
                          (if (let ()
                                (declare (not safe))
                                (##pair? _rest158218158226_))
                              (let ((_hd158223158293_
                                     (let ()
                                       (declare (not safe))
                                       (##car _rest158218158226_)))
                                    (_tl158224158295_
                                     (let ()
                                       (declare (not safe))
                                       (##cdr _rest158218158226_))))
                                (let* ((_expr158298_ _hd158223158293_)
                                       (_rest158300_ _tl158224158295_))
                                  (declare (not safe))
                                  (_K158222158290_ _rest158300_ _expr158298_)))
                              (let ()
                                (declare (not safe))
                                (_else158220158234_))))))))
                 (_compile-stub158142_
                  (lambda (_output-scm158149_ _output-bin158150_)
                    (let* ((_gerbil-home158152_
                            (getenv '"GERBIL_BUILD_PREFIX"
                                    (let ()
                                      (declare (not safe))
                                      (gerbil-home))))
                           (_gerbil-libdir158154_
                            (path-expand '"lib" _gerbil-home158152_))
                           (_runtime158156_
                            (map gxc#find-static-module-file
                                 gxc#gerbil-runtime-modules))
                           (_gambit-sharp158158_
                            (path-expand
                             '"lib/_gambit#.scm"
                             _gerbil-home158152_))
                           (_include-gambit-sharp158160_
                            (string-append
                             '"(include \""
                             _gambit-sharp158158_
                             '"\")"))
                           (_bin-scm158162_
                            (let ()
                              (declare (not safe))
                              (gxc#find-static-module-file _ctx158136_)))
                           (_deps158164_
                            (let ()
                              (declare (not safe))
                              (gxc#find-runtime-module-deps _ctx158136_)))
                           (_deps158166_
                            (map gxc#find-static-module-file _deps158164_))
                           (_deps158171_
                            (filter (lambda (_$obj158168_)
                                      (let ((__tmp158711
                                             (let ()
                                               (declare (not safe))
                                               (gxc#file-empty?
                                                _$obj158168_))))
                                        (declare (not safe))
                                        (not __tmp158711)))
                                    _deps158166_))
                           (_deps158175_
                            (filter (lambda (_f158173_)
                                      (let ((__tmp158712
                                             (member _f158173_
                                                     _runtime158156_)))
                                        (declare (not safe))
                                        (not __tmp158712)))
                                    _deps158171_))
                           (_output-base158177_
                            (string-append
                             (path-strip-extension _output-scm158149_)))
                           (_output-c158179_
                            (string-append _output-base158177_ '".c"))
                           (_output-o158181_
                            (string-append _output-base158177_ '".o"))
                           (_output-c_158183_
                            (string-append _output-base158177_ '"_.c"))
                           (_output-o_158185_
                            (string-append _output-base158177_ '"_.o"))
                           (_gsc-link-opts158187_
                            (let ()
                              (declare (not safe))
                              (gxc#gsc-link-options__0)))
                           (_gsc-cc-opts158189_
                            (let ()
                              (declare (not safe))
                              (gxc#gsc-cc-options__0)))
                           (_gsc-static-opts158191_
                            (let ((__tmp158713
                                   (path-expand
                                    '"static"
                                    _gerbil-libdir158154_)))
                              (declare (not safe))
                              (gxc#gsc-static-include-options __tmp158713)))
                           (_output-ld-opts158193_
                            (let () (declare (not safe)) (gxc#gcc-ld-options)))
                           (_gsc-gx-macros158195_
                            (if (let ()
                                  (declare (not safe))
                                  (gerbil-runtime-smp?))
                                (let ((__tmp158715
                                       (let ((__tmp158716
                                              (let ((__tmp158717
                                                     (let ()
                                                       (declare (not safe))
                                                       (cons _include-gambit-sharp158160_
                                                             '()))))
                                                (declare (not safe))
                                                (cons '"-e" __tmp158717))))
                                         (declare (not safe))
                                         (cons '"(define-cond-expand-feature|enable-smp|)"
                                               __tmp158716))))
                                  (declare (not safe))
                                  (cons '"-e" __tmp158715))
                                (let ((__tmp158714
                                       (let ()
                                         (declare (not safe))
                                         (cons _include-gambit-sharp158160_
                                               '()))))
                                  (declare (not safe))
                                  (cons '"-e" __tmp158714))))
                           (_gsc-link-opts158197_
                            (append _gsc-link-opts158187_
                                    _gsc-gx-macros158195_))
                           (_rpath158199_
                            (let ()
                              (declare (not safe))
                              (gxc#gerbil-rpath _gerbil-libdir158154_)))
                           (_default-ld-options158201_
                            (let ((__tmp158718
                                   (let ()
                                     (declare (not safe))
                                     (cons '"-lm" '()))))
                              (declare (not safe))
                              (cons '"-ldl" __tmp158718))))
                      (let ((__tmp158719
                             (lambda ()
                               (let ((__tmp158720
                                      (path-directory _output-bin158150_)))
                                 (declare (not safe))
                                 (create-directory*__0 __tmp158720)))))
                        (declare (not safe))
                        (with-lock gxc#+driver-mutex+ __tmp158719))
                      (let ((__tmp158721
                             (lambda ()
                               (let ((__tmp158722
                                      (let ((__tmp158723
                                             (let ((__tmp158724
                                                    (let ()
                                                      (declare (not safe))
                                                      (cons _bin-scm158162_
                                                            '()))))
                                               (declare (not safe))
                                               (foldr1 cons
                                                       __tmp158724
                                                       _deps158175_))))
                                        (declare (not safe))
                                        (foldr1 cons
                                                __tmp158723
                                                _runtime158156_))))
                                 (declare (not safe))
                                 (_generate-stub158140_ __tmp158722)))))
                        (declare (not safe))
                        (gxc#with-output-to-scheme-file
                         _output-scm158149_
                         __tmp158721))
                      (if (gxc#current-compile-invoke-gsc)
                          (begin
                            (let ((__tmp158730
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gsc)))
                                  (__tmp158725
                                   (let ((__tmp158726
                                          (let ((__tmp158727
                                                 (let ((__tmp158728
                                                        (let ((__tmp158729
                                                               (let ()
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                         (declare (not safe))
                         (cons _output-scm158149_ '()))))
                  (declare (not safe))
                  (foldr1 cons __tmp158729 _gsc-link-opts158197_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (cons _output-c_158183_
                                                         __tmp158728))))
                                            (declare (not safe))
                                            (cons '"-o" __tmp158727))))
                                     (declare (not safe))
                                     (cons '"-link" __tmp158726))))
                              (declare (not safe))
                              (gxc#invoke __tmp158730 __tmp158725))
                            (let ((__tmp158736
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gsc)))
                                  (__tmp158731
                                   (let ((__tmp158732
                                          (let ((__tmp158733
                                                 (let ((__tmp158734
                                                        (let ((__tmp158735
                                                               (let ()
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                         (declare (not safe))
                         (cons _output-c_158183_ '()))))
                  (declare (not safe))
                  (cons _output-c158179_ __tmp158735))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (foldr1 cons
                                                           __tmp158734
                                                           _gsc-static-opts158191_))))
                                            (declare (not safe))
                                            (foldr1 cons
                                                    __tmp158733
                                                    _gsc-cc-opts158189_))))
                                     (declare (not safe))
                                     (cons '"-obj" __tmp158732))))
                              (declare (not safe))
                              (gxc#invoke __tmp158736 __tmp158731))
                            (let ((__tmp158746
                                   (let ()
                                     (declare (not safe))
                                     (gxc#gerbil-gcc)))
                                  (__tmp158737
                                   (let ((__tmp158738
                                          (let ((__tmp158739
                                                 (let ((__tmp158740
                                                        (let ((__tmp158741
                                                               (let ((__tmp158742
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                              (let ((__tmp158743
                                     (let ((__tmp158744
                                            (let ((__tmp158745
                                                   (let ()
                                                     (declare (not safe))
                                                     (cons '"-lgambit"
                                                           _default-ld-options158201_))))
                                              (declare (not safe))
                                              (cons _gerbil-libdir158154_
                                                    __tmp158745))))
                                       (declare (not safe))
                                       (cons '"-L" __tmp158744))))
                                (declare (not safe))
                                (cons _rpath158199_ __tmp158743))))
                         (declare (not safe))
                         (foldr1 cons __tmp158742 _output-ld-opts158193_))))
                  (declare (not safe))
                  (cons _output-o_158185_ __tmp158741))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (cons _output-o158181_
                                                         __tmp158740))))
                                            (declare (not safe))
                                            (cons _output-bin158150_
                                                  __tmp158739))))
                                     (declare (not safe))
                                     (cons '"-o" __tmp158738))))
                              (declare (not safe))
                              (gxc#invoke __tmp158746 __tmp158737)))
                          '#!void)))))
          (let* ((_output-bin158144_
                  (let ()
                    (declare (not safe))
                    (gxc#compile-exe-output-file _ctx158136_ _opts158137_)))
                 (_output-scm158146_
                  (string-append _output-bin158144_ '"__exe.scm")))
            (let ()
              (declare (not safe))
              (_compile-stub158142_ _output-scm158146_ _output-bin158144_))
            (if (gxc#current-compile-keep-scm)
                '#!void
                (delete-file _output-scm158146_))))))
    (define gxc#find-export-binding
      (lambda (_ctx158086_ _id158087_)
        (let ((_$e158133_
               (let ((__tmp158748
                      (lambda (_e158088158090_)
                        (let* ((_g158092158102_ _e158088158090_)
                               (_else158094158110_ (lambda () '#f))
                               (_K158096158114_ (lambda () '#t)))
                          (if (let ()
                                (declare (not safe))
                                (##structure-direct-instance-of?
                                 _g158092158102_
                                 'gx#module-export::t))
                              (let* ((_e158097158117_
                                      (let ()
                                        (declare (not safe))
                                        (##unchecked-structure-ref
                                         _g158092158102_
                                         '1
                                         gx#module-export::t
                                         '#f)))
                                     (_e158098158120_
                                      (let ()
                                        (declare (not safe))
                                        (##unchecked-structure-ref
                                         _g158092158102_
                                         '2
                                         gx#module-export::t
                                         '#f)))
                                     (_e158099158123_
                                      (let ()
                                        (declare (not safe))
                                        (##unchecked-structure-ref
                                         _g158092158102_
                                         '3
                                         gx#module-export::t
                                         '#f))))
                                (if (let ()
                                      (declare (not safe))
                                      (##eq? _e158099158123_ '0))
                                    (let ((_e158100158126_
                                           (let ()
                                             (declare (not safe))
                                             (##unchecked-structure-ref
                                              _g158092158102_
                                              '4
                                              gx#module-export::t
                                              '#f))))
                                      (if ((lambda (_g158128158130_)
                                             (let ()
                                               (declare (not safe))
                                               (eq? _g158128158130_
                                                    _id158087_)))
                                           _e158100158126_)
                                          (let ()
                                            (declare (not safe))
                                            (_K158096158114_))
                                          (let ()
                                            (declare (not safe))
                                            (_else158094158110_))))
                                    (let ()
                                      (declare (not safe))
                                      (_else158094158110_))))
                              (let ()
                                (declare (not safe))
                                (_else158094158110_))))))
                     (__tmp158747
                      (##structure-ref
                       _ctx158086_
                       '9
                       gx#module-context::t
                       '#f)))
                 (declare (not safe))
                 (find __tmp158748 __tmp158747))))
          (if _$e158133_
              (let ()
                (declare (not safe))
                (gx#core-resolve-module-export _$e158133_))
              '#f))))
    (define gxc#find-runtime-symbol
      (lambda (_ctx158078_ _id158079_)
        (let ((_$e158081_
               (let ()
                 (declare (not safe))
                 (gxc#find-export-binding _ctx158078_ _id158079_))))
          (if _$e158081_
              ((lambda (_bind158084_)
                 (if (let ()
                       (declare (not safe))
                       (##structure-instance-of?
                        _bind158084_
                        'gx#runtime-binding::t))
                     '#!void
                     (let ()
                       (declare (not safe))
                       (gxc#raise-compile-error
                        '"export is not a runtime binding"
                        _id158079_)))
                 (##structure-ref _bind158084_ '1 gx#binding::t '#f))
               _$e158081_)
              (let ((__tmp158749
                     (##structure-ref
                      _ctx158078_
                      '1
                      gx#expander-context::t
                      '#f)))
                (declare (not safe))
                (gxc#raise-compile-error
                 '"module does not export symbol"
                 __tmp158749
                 _id158079_))))))
    (define gxc#find-runtime-module-deps
      (lambda (_ctx157965_)
        (letrec* ((_ht157967_
                   (let () (declare (not safe)) (make-hash-table-eq)))
                  (_import-set-template157968_
                   (lambda (_in158030_ _phi158031_)
                     (let ((_iphi158033_
                            (fx+ _phi158031_
                                 (##direct-structure-ref
                                  _in158030_
                                  '2
                                  gx#import-set::t
                                  '#f)))
                           (_imports158034_
                            (##structure-ref
                             (##direct-structure-ref
                              _in158030_
                              '1
                              gx#import-set::t
                              '#f)
                             '8
                             gx#module-context::t
                             '#f)))
                       (let _lp158036_ ((_rest158038_ _imports158034_)
                                        (_r158039_ '()))
                         (let* ((_rest158040158048_ _rest158038_)
                                (_else158042158056_ (lambda () _r158039_))
                                (_K158044158066_
                                 (lambda (_rest158059_ _in158060_)
                                   (if (let ()
                                         (declare (not safe))
                                         (##structure-instance-of?
                                          _in158060_
                                          'gx#module-context::t))
                                       (if (let ()
                                             (declare (not safe))
                                             (fxzero? _iphi158033_))
                                           (let ((__tmp158756
                                                  (let ()
                                                    (declare (not safe))
                                                    (cons _in158060_
                                                          _r158039_))))
                                             (declare (not safe))
                                             (_lp158036_
                                              _rest158059_
                                              __tmp158756))
                                           (let ()
                                             (declare (not safe))
                                             (_lp158036_
                                              _rest158059_
                                              _r158039_)))
                                       (if (let ()
                                             (declare (not safe))
                                             (##structure-direct-instance-of?
                                              _in158060_
                                              'gx#module-import::t))
                                           (let ((_iphi158062_
                                                  (fx+ _phi158031_
                                                       (##direct-structure-ref
                                                        _in158060_
                                                        '3
                                                        gx#module-import::t
                                                        '#f))))
                                             (if (let ()
                                                   (declare (not safe))
                                                   (fxzero? _iphi158062_))
                                                 (let ((__tmp158754
                                                        (let ((__tmp158755
                                                               (##direct-structure-ref
                                                                (##direct-structure-ref
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                         _in158060_
                         '1
                         gx#module-import::t
                         '#f)
                        '1
                        gx#module-export::t
                        '#f)))
                  (declare (not safe))
                  (cons __tmp158755 _r158039_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (declare (not safe))
                                                   (_lp158036_
                                                    _rest158059_
                                                    __tmp158754))
                                                 (let ()
                                                   (declare (not safe))
                                                   (_lp158036_
                                                    _rest158059_
                                                    _r158039_))))
                                           (if (let ()
                                                 (declare (not safe))
                                                 (##structure-direct-instance-of?
                                                  _in158060_
                                                  'gx#import-set::t))
                                               (let ((_xphi158064_
                                                      (fx+ _iphi158033_
                                                           (##direct-structure-ref
                                                            _in158060_
                                                            '2
                                                            gx#import-set::t
                                                            '#f))))
                                                 (if (let ()
                                                       (declare (not safe))
                                                       (fxzero? _xphi158064_))
                                                     (let ((__tmp158752
                                                            (let ((__tmp158753
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                           (##direct-structure-ref
                            _in158060_
                            '1
                            gx#import-set::t
                            '#f)))
                      (declare (not safe))
                      (cons __tmp158753 _r158039_))))
               (declare (not safe))
               (_lp158036_ _rest158059_ __tmp158752))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                     (if (fxpositive?
                                                          _xphi158064_)
                                                         (let ((__tmp158750
                                                                (let ((__tmp158751
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (let ()
                                 (declare (not safe))
                                 (_import-set-template157968_
                                  _in158060_
                                  _iphi158033_))))
                          (declare (not safe))
                          (foldl1 cons _r158039_ __tmp158751))))
                   (declare (not safe))
                   (_lp158036_ _rest158059_ __tmp158750))
                 (let ()
                   (declare (not safe))
                   (_lp158036_ _rest158059_ _r158039_)))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                               (let ()
                                                 (declare (not safe))
                                                 (_lp158036_
                                                  _rest158059_
                                                  _r158039_))))))))
                           (if (let ()
                                 (declare (not safe))
                                 (##pair? _rest158040158048_))
                               (let ((_hd158045158069_
                                      (let ()
                                        (declare (not safe))
                                        (##car _rest158040158048_)))
                                     (_tl158046158071_
                                      (let ()
                                        (declare (not safe))
                                        (##cdr _rest158040158048_))))
                                 (let* ((_in158074_ _hd158045158069_)
                                        (_rest158076_ _tl158046158071_))
                                   (declare (not safe))
                                   (_K158044158066_ _rest158076_ _in158074_)))
                               (let ()
                                 (declare (not safe))
                                 (_else158042158056_))))))))
                  (_find-deps157969_
                   (lambda (_rest157976_ _deps157977_)
                     (let* ((_rest157978157986_ _rest157976_)
                            (_else157980157994_ (lambda () _deps157977_))
                            (_K157982158018_
                             (lambda (_rest157997_ _hd157998_)
                               (if (let ()
                                     (declare (not safe))
                                     (##structure-instance-of?
                                      _hd157998_
                                      'gx#module-context::t))
                                   (let ((_id158000_
                                          (##structure-ref
                                           _hd157998_
                                           '1
                                           gx#expander-context::t
                                           '#f))
                                         (_imports158001_
                                          (##structure-ref
                                           _hd157998_
                                           '8
                                           gx#module-context::t
                                           '#f)))
                                     (if (let ()
                                           (declare (not safe))
                                           (hash-get _ht157967_ _id158000_))
                                         (let ()
                                           (declare (not safe))
                                           (_find-deps157969_
                                            _rest157997_
                                            _deps157977_))
                                         (let ((_$e158003_
                                                (let ()
                                                  (declare (not safe))
                                                  (gx#core-context-prelude__%
                                                   _hd157998_))))
                                           (if _$e158003_
                                               ((lambda (_pre158006_)
                                                  (let ((_xdeps158008_
                                                         (let ((__tmp158769
                                                                (let ()
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                          (declare (not safe))
                          (cons _pre158006_ _imports158001_))))
                   (declare (not safe))
                   (_find-deps157969_ __tmp158769 _deps157977_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (let ()
                                                      (declare (not safe))
                                                      (hash-put!
                                                       _ht157967_
                                                       _id158000_
                                                       _hd157998_))
                                                    (let ((__tmp158770
                                                           (let ()
                                                             (declare
                                                               (not safe))
                                                             (cons _hd157998_
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                           _xdeps158008_))))
              (declare (not safe))
              (_find-deps157969_ _rest157997_ __tmp158770))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                _$e158003_)
                                               (let ((_xdeps158010_
                                                      (let ()
                                                        (declare (not safe))
                                                        (_find-deps157969_
                                                         _imports158001_
                                                         _deps157977_))))
                                                 (let ()
                                                   (declare (not safe))
                                                   (hash-put!
                                                    _ht157967_
                                                    _id158000_
                                                    _hd157998_))
                                                 (let ((__tmp158768
                                                        (let ()
                                                          (declare (not safe))
                                                          (cons _hd157998_
                                                                _xdeps158010_))))
                                                   (declare (not safe))
                                                   (_find-deps157969_
                                                    _rest157997_
                                                    __tmp158768)))))))
                                   (if (let ()
                                         (declare (not safe))
                                         (##structure-instance-of?
                                          _hd157998_
                                          'gx#prelude-context::t))
                                       (let ((_id158012_
                                              (##structure-ref
                                               _hd157998_
                                               '1
                                               gx#expander-context::t
                                               '#f)))
                                         (if (let ()
                                               (declare (not safe))
                                               (hash-get
                                                _ht157967_
                                                _id158012_))
                                             (let ()
                                               (declare (not safe))
                                               (_find-deps157969_
                                                _rest157997_
                                                _deps157977_))
                                             (let ((_xdeps158014_
                                                    (let ((__tmp158766
                                                           (##structure-ref
                                                            _hd157998_
                                                            '7
                                                            gx#prelude-context::t
                                                            '#f)))
                                                      (declare (not safe))
                                                      (_find-deps157969_
                                                       __tmp158766
                                                       _deps157977_))))
                                               (if (let ()
                                                     (declare (not safe))
                                                     (hash-get
                                                      _ht157967_
                                                      _id158012_))
                                                   (let ()
                                                     (declare (not safe))
                                                     (_find-deps157969_
                                                      _rest157997_
                                                      _xdeps158014_))
                                                   (begin
                                                     (let ()
                                                       (declare (not safe))
                                                       (hash-put!
                                                        _ht157967_
                                                        _id158012_
                                                        _hd157998_))
                                                     (let ((__tmp158767
                                                            (let ()
                                                              (declare
                                                                (not safe))
                                                              (cons _hd157998_
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                            _xdeps158014_))))
               (declare (not safe))
               (_find-deps157969_ _rest157997_ __tmp158767)))))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                       (if (let ()
                                             (declare (not safe))
                                             (##structure-direct-instance-of?
                                              _hd157998_
                                              'gx#module-import::t))
                                           (if (let ((__tmp158765
                                                      (##direct-structure-ref
                                                       _hd157998_
                                                       '3
                                                       gx#module-import::t
                                                       '#f)))
                                                 (declare (not safe))
                                                 (fxzero? __tmp158765))
                                               (let ((__tmp158763
                                                      (let ((__tmp158764
                                                             (##direct-structure-ref
                                                              _hd157998_
                                                              '1
                                                              gx#module-import::t
                                                              '#f)))
                                                        (declare (not safe))
                                                        (cons __tmp158764
                                                              _rest157997_))))
                                                 (declare (not safe))
                                                 (_find-deps157969_
                                                  __tmp158763
                                                  _deps157977_))
                                               (let ()
                                                 (declare (not safe))
                                                 (_find-deps157969_
                                                  _rest157997_
                                                  _deps157977_)))
                                           (if (let ()
                                                 (declare (not safe))
                                                 (##structure-direct-instance-of?
                                                  _hd157998_
                                                  'gx#module-export::t))
                                               (let ((__tmp158761
                                                      (let ((__tmp158762
                                                             (##direct-structure-ref
                                                              _hd157998_
                                                              '1
                                                              gx#module-export::t
                                                              '#f)))
                                                        (declare (not safe))
                                                        (cons __tmp158762
                                                              _rest157997_))))
                                                 (declare (not safe))
                                                 (_find-deps157969_
                                                  __tmp158761
                                                  _deps157977_))
                                               (if (let ()
                                                     (declare (not safe))
                                                     (##structure-direct-instance-of?
                                                      _hd157998_
                                                      'gx#import-set::t))
                                                   (if (let ((__tmp158760
                                                              (##direct-structure-ref
                                                               _hd157998_
                                                               '2
                                                               gx#import-set::t
                                                               '#f)))
                                                         (declare (not safe))
                                                         (fxzero? __tmp158760))
                                                       (let ((__tmp158758
                                                              (let ((__tmp158759
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                             (##direct-structure-ref
                              _hd157998_
                              '1
                              gx#import-set::t
                              '#f)))
                        (declare (not safe))
                        (cons __tmp158759 _rest157997_))))
                 (declare (not safe))
                 (_find-deps157969_ __tmp158758 _deps157977_))
               (if (fxpositive?
                    (##direct-structure-ref
                     _hd157998_
                     '2
                     gx#import-set::t
                     '#f))
                   (let* ((_xdeps158016_
                           (let ()
                             (declare (not safe))
                             (_import-set-template157968_ _hd157998_ '0)))
                          (__tmp158757
                           (let ()
                             (declare (not safe))
                             (foldl1 cons _rest157997_ _xdeps158016_))))
                     (declare (not safe))
                     (_find-deps157969_ __tmp158757 _deps157977_))
                   (let ()
                     (declare (not safe))
                     (_find-deps157969_ _rest157997_ _deps157977_))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                   (let ()
                                                     (declare (not safe))
                                                     (error '"Unexpected module import"
                                                            _hd157998_))))))))))
                       (if (let ()
                             (declare (not safe))
                             (##pair? _rest157978157986_))
                           (let ((_hd157983158021_
                                  (let ()
                                    (declare (not safe))
                                    (##car _rest157978157986_)))
                                 (_tl157984158023_
                                  (let ()
                                    (declare (not safe))
                                    (##cdr _rest157978157986_))))
                             (let* ((_hd158026_ _hd157983158021_)
                                    (_rest158028_ _tl157984158023_))
                               (declare (not safe))
                               (_K157982158018_ _rest158028_ _hd158026_)))
                           (let ()
                             (declare (not safe))
                             (_else157980157994_)))))))
          (reverse (filter gx#expander-context-id
                           (let ((__tmp158771
                                  (let ((_$e157971_
                                         (let ()
                                           (declare (not safe))
                                           (gx#core-context-prelude__%
                                            _ctx157965_))))
                                    (if _$e157971_
                                        ((lambda (_pre157974_)
                                           (let ((__tmp158772
                                                  (##structure-ref
                                                   _ctx157965_
                                                   '8
                                                   gx#module-context::t
                                                   '#f)))
                                             (declare (not safe))
                                             (cons _pre157974_ __tmp158772)))
                                         _$e157971_)
                                        (##structure-ref
                                         _ctx157965_
                                         '8
                                         gx#module-context::t
                                         '#f)))))
                             (declare (not safe))
                             (_find-deps157969_ __tmp158771 '())))))))
    (define gxc#find-static-module-file
      (lambda (_ctx157896_)
        (let* ((_context-id157898_
                (if (let ()
                      (declare (not safe))
                      (##structure-instance-of?
                       _ctx157896_
                       'gx#module-context::t))
                    (##structure-ref _ctx157896_ '1 gx#expander-context::t '#f)
                    (string->symbol _ctx157896_)))
               (_scm157900_
                (string-append
                 (let ()
                   (declare (not safe))
                   (gxc#static-module-name _context-id157898_))
                 '".scm"))
               (_dirs157902_ (let () (declare (not safe)) (load-path)))
               (_dirs157908_
                (let ((_user-libpath157904_ (getenv '"GERBIL_PATH" '#f)))
                  (if _user-libpath157904_
                      (let ((_user-libpath157906_
                             (path-expand '"lib" _user-libpath157904_)))
                        (if (member _user-libpath157906_ _dirs157902_)
                            _dirs157902_
                            (let ()
                              (declare (not safe))
                              (cons _user-libpath157906_ _dirs157902_))))
                      _dirs157902_)))
               (_dirs157917_
                (let ((_$e157910_ (gxc#current-compile-output-dir)))
                  (if _$e157910_
                      ((lambda (_g157912157914_)
                         (let ()
                           (declare (not safe))
                           (cons _g157912157914_ _dirs157908_)))
                       _$e157910_)
                      _dirs157908_)))
               (_dirs157923_
                (map (lambda (_g157918157920_)
                       (path-expand '"static" _g157918157920_))
                     _dirs157917_)))
          (let _lp157926_ ((_rest157928_ _dirs157923_))
            (let* ((_rest157929157937_ _rest157928_)
                   (_else157931157945_
                    (lambda ()
                      (let ((__tmp158773
                             (##structure-ref
                              _ctx157896_
                              '1
                              gx#expander-context::t
                              '#f)))
                        (declare (not safe))
                        (gxc#raise-compile-error
                         '"cannot find static module"
                         __tmp158773
                         _scm157900_))))
                   (_K157933157953_
                    (lambda (_rest157948_ _dir157949_)
                      (let ((_path157951_
                             (path-expand _scm157900_ _dir157949_)))
                        (if (file-exists? _path157951_)
                            _path157951_
                            (let ()
                              (declare (not safe))
                              (_lp157926_ _rest157948_)))))))
              (if (let () (declare (not safe)) (##pair? _rest157929157937_))
                  (let ((_hd157934157956_
                         (let ()
                           (declare (not safe))
                           (##car _rest157929157937_)))
                        (_tl157935157958_
                         (let ()
                           (declare (not safe))
                           (##cdr _rest157929157937_))))
                    (let* ((_dir157961_ _hd157934157956_)
                           (_rest157963_ _tl157935157958_))
                      (declare (not safe))
                      (_K157933157953_ _rest157963_ _dir157961_)))
                  (let () (declare (not safe)) (_else157931157945_))))))))
    (define gxc#file-empty?
      (lambda (_path157894_)
        (let ((__tmp158774 (file-info-size (file-info _path157894_ '#t))))
          (declare (not safe))
          (zero? __tmp158774))))
    (define gxc#compile-top-module
      (lambda (_ctx157883_)
        (let ((__tmp158778
               (lambda ()
                 (let ((__tmp158779
                        (##structure-ref
                         _ctx157883_
                         '1
                         gx#expander-context::t
                         '#f)))
                   (declare (not safe))
                   (gxc#verbose '"compile " __tmp158779))
                 (if (gxc#current-compile-optimize)
                     (let ((__tmp158780
                            (lambda ()
                              (let ()
                                (declare (not safe))
                                (gxc#optimize! _ctx157883_)))))
                       (declare (not safe))
                       (with-lock gxc#+driver-mutex+ __tmp158780))
                     '#!void)
                 (let ()
                   (declare (not safe))
                   (gxc#collect-bindings _ctx157883_))
                 (if (let ((__tmp158783
                            (let ()
                              (declare (not safe))
                              (gxc#lift-nested-modules _ctx157883_))))
                       (declare (not safe))
                       (null? __tmp158783))
                     (let* ((_thr1157888_
                             (let ((__tmp158781
                                    (lambda ()
                                      (let ()
                                        (declare (not safe))
                                        (gxc#compile-runtime-code
                                         _ctx157883_)))))
                               (declare (not safe))
                               (spawn __tmp158781)))
                            (_thr2157891_
                             (let ((__tmp158782
                                    (lambda ()
                                      (let ()
                                        (declare (not safe))
                                        (gxc#compile-meta-code _ctx157883_)))))
                               (declare (not safe))
                               (spawn __tmp158782))))
                       (let () (declare (not safe)) (gxc#join! _thr1157888_))
                       (let () (declare (not safe)) (gxc#join! _thr2157891_)))
                     (begin
                       (let ()
                         (declare (not safe))
                         (gxc#compile-runtime-code _ctx157883_))
                       (let ()
                         (declare (not safe))
                         (gxc#compile-meta-code _ctx157883_))))
                 (if (and (gxc#current-compile-optimize)
                          (gxc#current-compile-generate-ssxi))
                     (let ()
                       (declare (not safe))
                       (gxc#compile-ssxi-code _ctx157883_))
                     '#!void)))
              (__tmp158777
               (let ((__obj158582
                      (let ()
                        (declare (not safe))
                        (##structure gxc#symbol-table::t '#f '#f))))
                 (gxc#symbol-table:::init! __obj158582)
                 __obj158582))
              (__tmp158776 (let () (declare (not safe)) (make-hash-table-eq)))
              (__tmp158775 (let () (declare (not safe)) (make-hash-table))))
          (declare (not safe))
          (call-with-parameters
           __tmp158778
           gx#current-expander-context
           _ctx157883_
           gx#current-expander-phi
           '0
           gx#current-expander-marks
           '()
           gxc#current-compile-symbol-table
           __tmp158777
           gxc#current-compile-runtime-sections
           __tmp158776
           gxc#current-compile-runtime-names
           __tmp158775))))
    (define gxc#collect-bindings
      (lambda (_ctx157881_)
        (let ((__tmp158784
               (##structure-ref _ctx157881_ '11 gx#module-context::t '#f)))
          (declare (not safe))
          (gxc#apply-collect-bindings __tmp158784))))
    (define gxc#compile-runtime-code
      (lambda (_ctx157822_)
        (letrec ((_compile1157824_
                  (lambda (_ctx157870_)
                    (let* ((_code157872_
                            (##structure-ref
                             _ctx157870_
                             '11
                             gx#module-context::t
                             '#f))
                           (_rt157876_
                            (if (let ()
                                  (declare (not safe))
                                  (gxc#apply-find-runtime-code _code157872_))
                                (let ((_idstr157874_
                                       (let ((__tmp158785
                                              (##structure-ref
                                               _ctx157870_
                                               '1
                                               gx#expander-context::t
                                               '#f)))
                                         (declare (not safe))
                                         (gxc#module-id->path-string
                                          __tmp158785))))
                                  (string->symbol
                                   (string-append _idstr157874_ '"--0")))
                                '#f)))
                      (if _rt157876_
                          (begin
                            (let ((__tmp158786
                                   (gxc#current-compile-runtime-sections)))
                              (declare (not safe))
                              (hash-put! __tmp158786 _ctx157870_ _rt157876_))
                            (let ()
                              (declare (not safe))
                              (_generate-runtime-code157826_
                               _ctx157870_
                               _code157872_)))
                          (let ((_path157879_
                                 (let ()
                                   (declare (not safe))
                                   (gxc#compile-static-output-file
                                    _ctx157870_))))
                            (declare (not safe))
                            (gxc#with-output-to-scheme-file
                             _path157879_
                             void)))
                      (let ()
                        (declare (not safe))
                        (_generate-loader-code157827_
                         _ctx157870_
                         _code157872_
                         _rt157876_)))))
                 (_context-timestamp157825_
                  (lambda (_ctx157868_)
                    (string->symbol
                     (string-append
                      (symbol->string
                       (##structure-ref
                        _ctx157868_
                        '1
                        gx#expander-context::t
                        '#f))
                      '"##timestamp"))))
                 (_generate-runtime-code157826_
                  (lambda (_ctx157848_ _code157849_)
                    (let* ((_lifts157851_
                            (let () (declare (not safe)) (box '())))
                           (_runtime-code157854_
                            (let ((__tmp158789
                                   (lambda ()
                                     (let ()
                                       (declare (not safe))
                                       (gxc#apply-generate-runtime
                                        _code157849_))))
                                  (__tmp158788
                                   (let ()
                                     (declare (not safe))
                                     (make-hash-table-eq)))
                                  (__tmp158787
                                   (let ()
                                     (declare (not safe))
                                     (gxc#make-bound-identifier-table))))
                              (declare (not safe))
                              (call-with-parameters
                               __tmp158789
                               gx#current-expander-context
                               _ctx157848_
                               gx#current-expander-phi
                               '0
                               gxc#current-compile-lift
                               _lifts157851_
                               gxc#current-compile-marks
                               __tmp158788
                               gxc#current-compile-identifiers
                               __tmp158787)))
                           (_runtime-code157856_
                            (if (let ((__tmp158793 (unbox _lifts157851_)))
                                  (declare (not safe))
                                  (null? __tmp158793))
                                _runtime-code157854_
                                (let ((__tmp158790
                                       (let ((__tmp158792
                                              (let ()
                                                (declare (not safe))
                                                (cons _runtime-code157854_
                                                      '())))
                                             (__tmp158791
                                              (reverse (unbox _lifts157851_))))
                                         (declare (not safe))
                                         (foldr1 cons
                                                 __tmp158792
                                                 __tmp158791))))
                                  (declare (not safe))
                                  (cons 'begin __tmp158790))))
                           (_runtime-code157858_
                            (let ((__tmp158794
                                   (let ((__tmp158796
                                          (let ((__tmp158797
                                                 (let ((__tmp158800
                                                        (let ()
                                                          (declare (not safe))
                                                          (_context-timestamp157825_
                                                           _ctx157848_)))
                                                       (__tmp158798
                                                        (let ((__tmp158799
                                                               (gxc#current-compile-timestamp)))
                                                          (declare (not safe))
                                                          (cons __tmp158799
                                                                '()))))
                                                   (declare (not safe))
                                                   (cons __tmp158800
                                                         __tmp158798))))
                                            (declare (not safe))
                                            (cons 'define __tmp158797)))
                                         (__tmp158795
                                          (let ()
                                            (declare (not safe))
                                            (cons _runtime-code157856_ '()))))
                                     (declare (not safe))
                                     (cons __tmp158796 __tmp158795))))
                              (declare (not safe))
                              (cons 'begin __tmp158794)))
                           (_runtime-module-id157860_
                            (let ((__tmp158801
                                   (##structure-ref
                                    _ctx157848_
                                    '1
                                    gx#expander-context::t
                                    '#f)))
                              (declare (not safe))
                              (make-symbol__1 __tmp158801 '"--" '0)))
                           (_scm0157862_
                            (let ()
                              (declare (not safe))
                              (gxc#compile-output-file
                               _ctx157848_
                               '0
                               '".scm")))
                           (_scms157864_
                            (let ()
                              (declare (not safe))
                              (gxc#compile-static-output-file _ctx157848_))))
                      (let ()
                        (declare (not safe))
                        (gxc#compile-scm-file
                         _scm0157862_
                         _runtime-code157858_
                         'supply:
                         _runtime-module-id157860_))
                      (if (file-exists? _scms157864_)
                          (delete-file _scms157864_)
                          '#!void)
                      (let ((__tmp158802
                             (lambda ()
                               (let ()
                                 (declare (not safe))
                                 (gxc#compile-scm-file
                                  _scms157864_
                                  _runtime-code157858_)))))
                        (declare (not safe))
                        (call-with-parameters
                         __tmp158802
                         gxc#current-compile-invoke-gsc
                         '#f
                         gxc#current-compile-keep-scm
                         '#t)))))
                 (_generate-loader-code157827_
                  (lambda (_ctx157834_ _code157835_ _rt157836_)
                    (let* ((_loader-deps157838_
                            (let () (declare (not safe)) (box '())))
                           (_g158804_
                            (let ((__tmp158803
                                   (lambda ()
                                     (let ()
                                       (declare (not safe))
                                       (gxc#apply-collect-loader-deps
                                        _code157835_
                                        'deps:
                                        _loader-deps157838_)))))
                              (declare (not safe))
                              (call-with-parameters
                               __tmp158803
                               gx#current-expander-context
                               _ctx157834_)))
                           (_loader-deps157842_
                            (reverse (unbox _loader-deps157838_)))
                           (_loader-deps157844_
                            (if _rt157836_
                                (append _loader-deps157842_
                                        (let ()
                                          (declare (not safe))
                                          (cons _rt157836_ '())))
                                _loader-deps157842_)))
                      (let ((__tmp158805
                             (lambda ()
                               (let ((__tmp158807
                                      (let ()
                                        (declare (not safe))
                                        (gxc#compile-output-file
                                         _ctx157834_
                                         '#f
                                         '".scm")))
                                     (__tmp158806
                                      (##structure-ref
                                       _ctx157834_
                                       '1
                                       gx#expander-context::t
                                       '#f)))
                                 (declare (not safe))
                                 (gxc#compile-scm-file
                                  __tmp158807
                                  '(void)
                                  'supply:
                                  __tmp158806
                                  'demand:
                                  _loader-deps157844_)))))
                        (declare (not safe))
                        (call-with-parameters
                         __tmp158805
                         gxc#current-compile-gsc-options
                         '#f))))))
          (let ((_all-modules157829_
                 (let ((__tmp158808
                        (let ()
                          (declare (not safe))
                          (gxc#lift-nested-modules _ctx157822_))))
                   (declare (not safe))
                   (cons _ctx157822_ __tmp158808))))
            (for-each
             (lambda (_ctx157831_)
               (let ((__tmp158809
                      (lambda ()
                        (let ()
                          (declare (not safe))
                          (_compile1157824_ _ctx157831_)))))
                 (declare (not safe))
                 (call-with-parameters
                  __tmp158809
                  gxc#current-compile-decls
                  '())))
             _all-modules157829_)))))
    (define gxc#compile-meta-code
      (lambda (_ctx157716_)
        (letrec ((_compile-ssi157718_
                  (lambda (_code157792_)
                    (let* ((_path157794_
                            (let ()
                              (declare (not safe))
                              (gxc#compile-output-file
                               _ctx157716_
                               '#f
                               '".ssi")))
                           (_prelude157805_
                            (let* ((_super157796_
                                    (##structure-ref
                                     _ctx157716_
                                     '3
                                     gx#phi-context::t
                                     '#f))
                                   (_$e157798_
                                    (##structure-ref
                                     _super157796_
                                     '1
                                     gx#expander-context::t
                                     '#f)))
                              (if _$e157798_
                                  ((lambda (_g157800157802_)
                                     (let ()
                                       (declare (not safe))
                                       (make-symbol__1 '":" _g157800157802_)))
                                   _$e157798_)
                                  ':<root>)))
                           (_ns157807_
                            (##structure-ref
                             _ctx157716_
                             '6
                             gx#module-context::t
                             '#f))
                           (_idstr157809_
                            (symbol->string
                             (##structure-ref
                              _ctx157716_
                              '1
                              gx#expander-context::t
                              '#f)))
                           (_pkg157816_
                            (let ((_$e157811_
                                   (let ()
                                     (declare (not safe))
                                     (string-rindex__0 _idstr157809_ '#\/))))
                              (if _$e157811_
                                  ((lambda (_x157814_)
                                     (string->symbol
                                      (substring _idstr157809_ '0 _x157814_)))
                                   _$e157811_)
                                  '#f)))
                           (_rt157818_
                            (let ((__tmp158810
                                   (gxc#current-compile-runtime-sections)))
                              (declare (not safe))
                              (hash-get __tmp158810 _ctx157716_))))
                      (let ()
                        (declare (not safe))
                        (gxc#verbose '"compile " _path157794_))
                      (let ((__tmp158811
                             (lambda ()
                               (let ()
                                 (declare (not safe))
                                 (displayln '"prelude:" '" " _prelude157805_))
                               (if _pkg157816_
                                   (let ()
                                     (declare (not safe))
                                     (displayln '"package:" '" " _pkg157816_))
                                   '#!void)
                               (let ()
                                 (declare (not safe))
                                 (displayln '"namespace:" '" " _ns157807_))
                               (newline)
                               (pretty-print _code157792_)
                               (if _rt157818_
                                   (pretty-print
                                    (let ((__tmp158812
                                           (let ((__tmp158817
                                                  (let ((__tmp158818
                                                         (let ()
                                                           (declare (not safe))
                                                           (cons 'load-module
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                         '()))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons '%#ref __tmp158818)))
                                                 (__tmp158813
                                                  (let ((__tmp158814
                                                         (let ((__tmp158815
                                                                (let ((__tmp158816
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                               (##structure-ref
                                _ctx157716_
                                '1
                                gx#expander-context::t
                                '#f)))
                          (declare (not safe))
                          (cons __tmp158816 '()))))
                   (declare (not safe))
                   (cons '%#quote __tmp158815))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                    (declare (not safe))
                                                    (cons __tmp158814 '()))))
                                             (declare (not safe))
                                             (cons __tmp158817 __tmp158813))))
                                      (declare (not safe))
                                      (cons '%#call __tmp158812)))
                                   '#!void))))
                        (declare (not safe))
                        (gxc#with-output-to-scheme-file
                         _path157794_
                         __tmp158811)))))
                 (_compile-phi157719_
                  (lambda (_part157729_)
                    (let* ((_part157730157743_ _part157729_)
                           (_E157732157747_
                            (lambda ()
                              (let ()
                                (declare (not safe))
                                (error '"No clause matching"
                                       _part157730157743_))))
                           (_K157733157761_
                            (lambda (_code157750_
                                     _n157751_
                                     _phi157752_
                                     _phi-ctx157753_)
                              (let* ((_code157756_
                                      (let ((__tmp158819
                                             (lambda ()
                                               (let ()
                                                 (declare (not safe))
                                                 (gxc#generate-runtime-phi
                                                  _code157750_)))))
                                        (declare (not safe))
                                        (call-with-parameters
                                         __tmp158819
                                         gx#current-expander-context
                                         _phi-ctx157753_
                                         gx#current-expander-phi
                                         _phi157752_)))
                                     (_module-id157758_
                                      (let ((__tmp158820
                                             (##structure-ref
                                              _ctx157716_
                                              '1
                                              gx#expander-context::t
                                              '#f)))
                                        (declare (not safe))
                                        (make-symbol__1
                                         __tmp158820
                                         '"--"
                                         _n157751_))))
                                (let ((__tmp158821
                                       (let ()
                                         (declare (not safe))
                                         (gxc#compile-output-file
                                          _ctx157716_
                                          _n157751_
                                          '".scm"))))
                                  (declare (not safe))
                                  (gxc#compile-scm-file
                                   __tmp158821
                                   _code157756_
                                   '#t
                                   'supply:
                                   _module-id157758_))))))
                      (if (let ()
                            (declare (not safe))
                            (##pair? _part157730157743_))
                          (let ((_hd157734157764_
                                 (let ()
                                   (declare (not safe))
                                   (##car _part157730157743_)))
                                (_tl157735157766_
                                 (let ()
                                   (declare (not safe))
                                   (##cdr _part157730157743_))))
                            (let ((_phi-ctx157769_ _hd157734157764_))
                              (if (let ()
                                    (declare (not safe))
                                    (##pair? _tl157735157766_))
                                  (let ((_hd157736157771_
                                         (let ()
                                           (declare (not safe))
                                           (##car _tl157735157766_)))
                                        (_tl157737157773_
                                         (let ()
                                           (declare (not safe))
                                           (##cdr _tl157735157766_))))
                                    (let ((_phi157776_ _hd157736157771_))
                                      (if (let ()
                                            (declare (not safe))
                                            (##pair? _tl157737157773_))
                                          (let ((_hd157738157778_
                                                 (let ()
                                                   (declare (not safe))
                                                   (##car _tl157737157773_)))
                                                (_tl157739157780_
                                                 (let ()
                                                   (declare (not safe))
                                                   (##cdr _tl157737157773_))))
                                            (let ((_n157783_ _hd157738157778_))
                                              (if (let ()
                                                    (declare (not safe))
                                                    (##pair? _tl157739157780_))
                                                  (let ((_hd157740157785_
                                                         (let ()
                                                           (declare (not safe))
                                                           (##car _tl157739157780_)))
                                                        (_tl157741157787_
                                                         (let ()
                                                           (declare (not safe))
                                                           (##cdr _tl157739157780_))))
                                                    (let ((_code157790_
                                                           _hd157740157785_))
                                                      (if (let ()
                                                            (declare
                                                              (not safe))
                                                            (##null? _tl157741157787_))
                                                          (let ()
                                                            (declare
                                                              (not safe))
                                                            (_K157733157761_
                                                             _code157790_
                                                             _n157783_
                                                             _phi157776_
                                                             _phi-ctx157769_))
                                                          (let ()
                                                            (declare
                                                              (not safe))
                                                            (_E157732157747_)))))
                                                  (let ()
                                                    (declare (not safe))
                                                    (_E157732157747_)))))
                                          (let ()
                                            (declare (not safe))
                                            (_E157732157747_)))))
                                  (let ()
                                    (declare (not safe))
                                    (_E157732157747_)))))
                          (let () (declare (not safe)) (_E157732157747_)))))))
          (let ((_g158822_
                 (let ()
                   (declare (not safe))
                   (gxc#generate-meta-code _ctx157716_))))
            (begin
              (let ((_g158823_
                     (let ()
                       (declare (not safe))
                       (if (##values? _g158822_)
                           (##vector-length _g158822_)
                           1))))
                (if (not (let () (declare (not safe)) (##fx= _g158823_ 2)))
                    (error "Context expects 2 values" _g158823_)))
              (let ((_ssi-code157721_
                     (let () (declare (not safe)) (##vector-ref _g158822_ 0)))
                    (_phi-code157722_
                     (let () (declare (not safe)) (##vector-ref _g158822_ 1))))
                (begin
                  (let ()
                    (declare (not safe))
                    (_compile-ssi157718_ _ssi-code157721_))
                  (let ((_threads157727_
                         (map (lambda (_code157724_)
                                (let ((__tmp158824
                                       (lambda ()
                                         (let ()
                                           (declare (not safe))
                                           (_compile-phi157719_
                                            _code157724_)))))
                                  (declare (not safe))
                                  (spawn __tmp158824)))
                              _phi-code157722_)))
                    (for-each gxc#join! _threads157727_)))))))))
    (define gxc#compile-ssxi-code
      (lambda (_ctx157699_)
        (let* ((_path157701_
                (let ()
                  (declare (not safe))
                  (gxc#compile-output-file _ctx157699_ '#f '".ssxi.ss")))
               (_code157703_
                (let ((__tmp158825
                       (##structure-ref
                        _ctx157699_
                        '11
                        gx#module-context::t
                        '#f)))
                  (declare (not safe))
                  (gxc#apply-generate-ssxi __tmp158825)))
               (_idstr157705_
                (symbol->string
                 (##structure-ref _ctx157699_ '1 gx#expander-context::t '#f)))
               (_pkg157712_
                (let ((_$e157707_
                       (let ()
                         (declare (not safe))
                         (string-rindex__0 _idstr157705_ '#\/))))
                  (if _$e157707_
                      ((lambda (_x157710_)
                         (string->symbol
                          (substring _idstr157705_ '0 _x157710_)))
                       _$e157707_)
                      '#f))))
          (let () (declare (not safe)) (gxc#verbose '"compile " _path157701_))
          (let ((__tmp158826
                 (lambda ()
                   (let ()
                     (declare (not safe))
                     (displayln '"prelude: :gerbil/compiler/ssxi"))
                   (if _pkg157712_
                       (let ()
                         (declare (not safe))
                         (displayln '"package: " _pkg157712_))
                       '#!void)
                   (newline)
                   (pretty-print _code157703_))))
            (declare (not safe))
            (gxc#with-output-to-scheme-file _path157701_ __tmp158826)))))
    (define gxc#generate-meta-code
      (lambda (_ctx157692_)
        (let* ((_state157694_
                (let ((__obj158583
                       (let ()
                         (declare (not safe))
                         (##structure gxc#meta-state::t '#f '#f '#f '#f))))
                  (gxc#meta-state:::init! __obj158583 _ctx157692_)
                  __obj158583))
               (_ssi-code157696_
                (let ((__tmp158827
                       (##structure-ref
                        _ctx157692_
                        '11
                        gx#module-context::t
                        '#f)))
                  (declare (not safe))
                  (gxc#apply-generate-meta
                   __tmp158827
                   'state:
                   _state157694_))))
          (values _ssi-code157696_
                  (let ()
                    (declare (not safe))
                    (gxc#meta-state-end! _state157694_))))))
    (define gxc#generate-runtime-phi
      (lambda (_stx157685_)
        (let ((_lifts157687_ (let () (declare (not safe)) (box '()))))
          (let ((__tmp158830
                 (lambda ()
                   (let ((_code157690_
                          (let ()
                            (declare (not safe))
                            (gxc#apply-generate-runtime-phi _stx157685_))))
                     (if (let ((__tmp158834 (unbox _lifts157687_)))
                           (declare (not safe))
                           (null? __tmp158834))
                         _code157690_
                         (let ((__tmp158831
                                (let ((__tmp158833
                                       (let ()
                                         (declare (not safe))
                                         (cons _code157690_ '())))
                                      (__tmp158832
                                       (reverse (unbox _lifts157687_))))
                                  (declare (not safe))
                                  (foldr1 cons __tmp158833 __tmp158832))))
                           (declare (not safe))
                           (cons 'begin __tmp158831))))))
                (__tmp158829
                 (let () (declare (not safe)) (make-hash-table-eq)))
                (__tmp158828
                 (let ()
                   (declare (not safe))
                   (gxc#make-bound-identifier-table))))
            (declare (not safe))
            (call-with-parameters
             __tmp158830
             gxc#current-compile-lift
             _lifts157687_
             gxc#current-compile-marks
             __tmp158829
             gxc#current-compile-identifiers
             __tmp158828)))))
    (define gxc#lift-nested-modules
      (lambda (_ctx157681_)
        (let ((_modules157683_ (let () (declare (not safe)) (box '()))))
          (let ((__tmp158835
                 (##structure-ref _ctx157681_ '11 gx#module-context::t '#f)))
            (declare (not safe))
            (gxc#apply-lift-modules __tmp158835 'modules: _modules157683_))
          (reverse (unbox _modules157683_)))))
    (define gxc#compile-scm-file__%__%
      (lambda (__157629157632_
               _module-id157626157634_
               _module-deps157627157636_
               _path157638_
               _code157639_
               _phi?157640_)
        (let* ((_module-id157642_
                (if (let ()
                      (declare (not safe))
                      (eq? _module-id157626157634_ absent-value))
                    '#f
                    _module-id157626157634_))
               (_module-deps157644_
                (if (let ()
                      (declare (not safe))
                      (eq? _module-deps157627157636_ absent-value))
                    '#f
                    _module-deps157627157636_)))
          (let () (declare (not safe)) (gxc#verbose '"compile " _path157638_))
          (let ((__tmp158836
                 (lambda ()
                   (pretty-print
                    (let ((__tmp158837
                           (let ((__tmp158844
                                  (let ()
                                    (declare (not safe))
                                    (cons 'block '())))
                                 (__tmp158838
                                  (let ((__tmp158843
                                         (let ()
                                           (declare (not safe))
                                           (cons 'standard-bindings '())))
                                        (__tmp158839
                                         (let ((__tmp158842
                                                (let ()
                                                  (declare (not safe))
                                                  (cons 'extended-bindings
                                                        '())))
                                               (__tmp158840
                                                (let ((__tmp158841
                                                       (if _phi?157640_
                                                           '((inlining-limit
                                                              200))
                                                           '())))
                                                  (declare (not safe))
                                                  (foldr1 cons
                                                          '()
                                                          __tmp158841))))
                                           (declare (not safe))
                                           (cons __tmp158842 __tmp158840))))
                                    (declare (not safe))
                                    (cons __tmp158843 __tmp158839))))
                             (declare (not safe))
                             (cons __tmp158844 __tmp158838))))
                      (declare (not safe))
                      (cons 'declare __tmp158837)))
                   (if _module-id157642_
                       (begin
                         (write (let ((__tmp158845
                                       (let ()
                                         (declare (not safe))
                                         (cons _module-id157642_ '()))))
                                  (declare (not safe))
                                  (cons '##supply-module __tmp158845)))
                         (newline))
                       '#!void)
                   (if _module-deps157644_
                       (for-each
                        (lambda (_dep157647_)
                          (if _dep157647_
                              (begin
                                (write (let ((__tmp158846
                                              (let ((__tmp158847
                                                     (let ((__tmp158848
                                                            (let ()
                                                              (declare
                                                                (not safe))
                                                              (cons _dep157647_
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                            '()))))
               (declare (not safe))
               (cons 'quote __tmp158848))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                (declare (not safe))
                                                (cons __tmp158847 '()))))
                                         (declare (not safe))
                                         (cons 'load-module __tmp158846)))
                                (newline))
                              '#!void))
                        _module-deps157644_)
                       '#!void)
                   (pretty-print _code157639_))))
            (declare (not safe))
            (gxc#with-output-to-scheme-file _path157638_ __tmp158836))
          (if (gxc#current-compile-invoke-gsc)
              (let ()
                (declare (not safe))
                (gxc#gsc-compile-file _path157638_ _phi?157640_))
              '#!void)
          (if (gxc#current-compile-keep-scm)
              '#!void
              (delete-file _path157638_)))))
    (define gxc#compile-scm-file__%__0
      (lambda (__157629157652_
               _module-id157626157653_
               _module-deps157627157654_
               _path157655_
               _code157656_)
        (let ((_phi?157658_ '#f))
          (declare (not safe))
          (gxc#compile-scm-file__%__%
           __157629157652_
           _module-id157626157653_
           _module-deps157627157654_
           _path157655_
           _code157656_
           _phi?157658_))))
    (define gxc#compile-scm-file__%
      (lambda _g158850_
        (let ((_g158849_ (let () (declare (not safe)) (##length _g158850_))))
          (cond ((let () (declare (not safe)) (##fx= _g158849_ 5))
                 (apply (lambda (__157629157652_
                                 _module-id157626157653_
                                 _module-deps157627157654_
                                 _path157655_
                                 _code157656_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-scm-file__%__0
                             __157629157652_
                             _module-id157626157653_
                             _module-deps157627157654_
                             _path157655_
                             _code157656_)))
                        _g158850_))
                ((let () (declare (not safe)) (##fx= _g158849_ 6))
                 (apply (lambda (__157629157660_
                                 _module-id157626157661_
                                 _module-deps157627157662_
                                 _path157663_
                                 _code157664_
                                 _phi?157665_)
                          (let ()
                            (declare (not safe))
                            (gxc#compile-scm-file__%__%
                             __157629157660_
                             _module-id157626157661_
                             _module-deps157627157662_
                             _path157663_
                             _code157664_
                             _phi?157665_)))
                        _g158850_))
                (else
                 (##raise-wrong-number-of-arguments-exception
                  gxc#compile-scm-file__%
                  _g158850_))))))
    (define gxc#compile-scm-file__@
      (lambda (_keys157625157670_ . _args157672_)
        (apply gxc#compile-scm-file__%
               _keys157625157670_
               (let ()
                 (declare (not safe))
                 (symbolic-table-ref _keys157625157670_ 'supply: absent-value))
               (let ()
                 (declare (not safe))
                 (symbolic-table-ref _keys157625157670_ 'demand: absent-value))
               _args157672_)))
    (define gxc#compile-scm-file
      (lambda _args157628157678_
        (apply keyword-dispatch
               '#(demand: supply: #f)
               gxc#compile-scm-file__@
               _args157628157678_)))
    (define gxc#gsc-link-options__%
      (lambda (_phi?157526_)
        (let _lp157528_ ((_rest157530_ (gxc#current-compile-gsc-options))
                         (_opts157531_ '()))
          (let* ((_rest157532157552_ _rest157530_)
                 (_else157536157560_
                  (lambda ()
                    (if (and (let () (declare (not safe)) (not _phi?157526_))
                             (gxc#current-compile-debug))
                        (let ((__tmp158851
                               (let ((__tmp158852 (reverse _opts157531_)))
                                 (declare (not safe))
                                 (cons '"-track-scheme" __tmp158852))))
                          (declare (not safe))
                          (cons '"-debug-source" __tmp158851))
                        (reverse _opts157531_)))))
            (let ((_K157546157603_
                   (lambda (_rest157601_)
                     (let ()
                       (declare (not safe))
                       (_lp157528_ _rest157601_ _opts157531_))))
                  (_K157541157585_
                   (lambda (_rest157583_)
                     (let ()
                       (declare (not safe))
                       (_lp157528_ _rest157583_ _opts157531_))))
                  (_K157538157567_
                   (lambda (_rest157564_ _opt157565_)
                     (let ((__tmp158853
                            (let ()
                              (declare (not safe))
                              (cons _opt157565_ _opts157531_))))
                       (declare (not safe))
                       (_lp157528_ _rest157564_ __tmp158853)))))
              (if (let () (declare (not safe)) (##pair? _rest157532157552_))
                  (let ((_tl157548157608_
                         (let ()
                           (declare (not safe))
                           (##cdr _rest157532157552_)))
                        (_hd157547157606_
                         (let ()
                           (declare (not safe))
                           (##car _rest157532157552_))))
                    (if (let ()
                          (declare (not safe))
                          (equal? _hd157547157606_ '"-cc-options"))
                        (if (let ()
                              (declare (not safe))
                              (##pair? _tl157548157608_))
                            (let* ((_tl157550157611_
                                    (let ()
                                      (declare (not safe))
                                      (##cdr _tl157548157608_)))
                                   (_rest157614_ _tl157550157611_))
                              (declare (not safe))
                              (_K157546157603_ _rest157614_))
                            (let ((_opt157575_ _hd157547157606_)
                                  (_rest157577_ _tl157548157608_))
                              (let ()
                                (declare (not safe))
                                (_K157538157567_ _rest157577_ _opt157575_))))
                        (if (let ()
                              (declare (not safe))
                              (equal? _hd157547157606_ '"-ld-options"))
                            (if (let ()
                                  (declare (not safe))
                                  (##pair? _tl157548157608_))
                                (let* ((_tl157545157593_
                                        (let ()
                                          (declare (not safe))
                                          (##cdr _tl157548157608_)))
                                       (_rest157596_ _tl157545157593_))
                                  (declare (not safe))
                                  (_K157541157585_ _rest157596_))
                                (let ((_opt157575_ _hd157547157606_)
                                      (_rest157577_ _tl157548157608_))
                                  (let ()
                                    (declare (not safe))
                                    (_K157538157567_
                                     _rest157577_
                                     _opt157575_))))
                            (let ((_opt157575_ _hd157547157606_)
                                  (_rest157577_ _tl157548157608_))
                              (let ()
                                (declare (not safe))
                                (_K157538157567_ _rest157577_ _opt157575_))))))
                  (let () (declare (not safe)) (_else157536157560_))))))))
    (define gxc#gsc-link-options__0
      (lambda ()
        (let ((_phi?157620_ '#f))
          (declare (not safe))
          (gxc#gsc-link-options__% _phi?157620_))))
    (define gxc#gsc-link-options
      (lambda _g158855_
        (let ((_g158854_ (let () (declare (not safe)) (##length _g158855_))))
          (cond ((let () (declare (not safe)) (##fx= _g158854_ 0))
                 (apply (lambda ()
                          (let ()
                            (declare (not safe))
                            (gxc#gsc-link-options__0)))
                        _g158855_))
                ((let () (declare (not safe)) (##fx= _g158854_ 1))
                 (apply (lambda (_phi?157622_)
                          (let ()
                            (declare (not safe))
                            (gxc#gsc-link-options__% _phi?157622_)))
                        _g158855_))
                (else
                 (##raise-wrong-number-of-arguments-exception
                  gxc#gsc-link-options
                  _g158855_))))))
    (define gxc#gsc-cc-options__%
      (lambda (_phi?157427_)
        (let _lp157429_ ((_rest157431_ (gxc#current-compile-gsc-options))
                         (_opts157432_ '()))
          (let* ((_rest157433157453_ _rest157431_)
                 (_else157437157461_
                  (lambda ()
                    (if (and (let () (declare (not safe)) (not _phi?157427_))
                             (gxc#current-compile-debug))
                        (let ((__tmp158856
                               (let ((__tmp158857 (reverse _opts157432_)))
                                 (declare (not safe))
                                 (cons '"-g" __tmp158857))))
                          (declare (not safe))
                          (cons '"-cc-options" __tmp158856))
                        (reverse _opts157432_)))))
            (let ((_K157447157500_
                   (lambda (_rest157497_ _opt157498_)
                     (let ((__tmp158858
                            (let ((__tmp158859
                                   (let ()
                                     (declare (not safe))
                                     (cons '"-cc-options" _opts157432_))))
                              (declare (not safe))
                              (cons _opt157498_ __tmp158859))))
                       (declare (not safe))
                       (_lp157429_ _rest157497_ __tmp158858))))
                  (_K157442157481_
                   (lambda (_rest157479_)
                     (let ()
                       (declare (not safe))
                       (_lp157429_ _rest157479_ _opts157432_))))
                  (_K157439157467_
                   (lambda (_rest157465_)
                     (let ()
                       (declare (not safe))
                       (_lp157429_ _rest157465_ _opts157432_)))))
              (if (let () (declare (not safe)) (##pair? _rest157433157453_))
                  (let ((_tl157449157505_
                         (let ()
                           (declare (not safe))
                           (##cdr _rest157433157453_)))
                        (_hd157448157503_
                         (let ()
                           (declare (not safe))
                           (##car _rest157433157453_))))
                    (if (let ()
                          (declare (not safe))
                          (equal? _hd157448157503_ '"-cc-options"))
                        (if (let ()
                              (declare (not safe))
                              (##pair? _tl157449157505_))
                            (let ((_tl157451157510_
                                   (let ()
                                     (declare (not safe))
                                     (##cdr _tl157449157505_)))
                                  (_hd157450157508_
                                   (let ()
                                     (declare (not safe))
                                     (##car _tl157449157505_))))
                              (let ((_opt157513_ _hd157450157508_)
                                    (_rest157515_ _tl157451157510_))
                                (let ()
                                  (declare (not safe))
                                  (_K157447157500_ _rest157515_ _opt157513_))))
                            (let ((_rest157473_ _tl157449157505_))
                              (declare (not safe))
                              (_K157439157467_ _rest157473_)))
                        (if (let ()
                              (declare (not safe))
                              (equal? _hd157448157503_ '"-ld-options"))
                            (if (let ()
                                  (declare (not safe))
                                  (##pair? _tl157449157505_))
                                (let* ((_tl157446157489_
                                        (let ()
                                          (declare (not safe))
                                          (##cdr _tl157449157505_)))
                                       (_rest157492_ _tl157446157489_))
                                  (declare (not safe))
                                  (_K157442157481_ _rest157492_))
                                (let ((_rest157473_ _tl157449157505_))
                                  (declare (not safe))
                                  (_K157439157467_ _rest157473_)))
                            (let ((_rest157473_ _tl157449157505_))
                              (declare (not safe))
                              (_K157439157467_ _rest157473_)))))
                  (let () (declare (not safe)) (_else157437157461_))))))))
    (define gxc#gsc-cc-options__0
      (lambda ()
        (let ((_phi?157521_ '#f))
          (declare (not safe))
          (gxc#gsc-cc-options__% _phi?157521_))))
    (define gxc#gsc-cc-options
      (lambda _g158861_
        (let ((_g158860_ (let () (declare (not safe)) (##length _g158861_))))
          (cond ((let () (declare (not safe)) (##fx= _g158860_ 0))
                 (apply (lambda ()
                          (let ()
                            (declare (not safe))
                            (gxc#gsc-cc-options__0)))
                        _g158861_))
                ((let () (declare (not safe)) (##fx= _g158860_ 1))
                 (apply (lambda (_phi?157523_)
                          (let ()
                            (declare (not safe))
                            (gxc#gsc-cc-options__% _phi?157523_)))
                        _g158861_))
                (else
                 (##raise-wrong-number-of-arguments-exception
                  gxc#gsc-cc-options
                  _g158861_))))))
    (define gxc#gsc-static-include-options
      (lambda (_staticdir157422_)
        (let* ((_user-staticdir157424_
                (path-expand
                 (path-expand
                  '"lib/static"
                  (let () (declare (not safe)) (gerbil-path)))))
               (__tmp158862
                (let ((__tmp158863
                       (string-append
                        '"-I "
                        _staticdir157422_
                        '" -I "
                        _user-staticdir157424_)))
                  (declare (not safe))
                  (cons __tmp158863 '()))))
          (declare (not safe))
          (cons '"-cc-options" __tmp158862))))
    (define gxc#gcc-ld-options
      (lambda ()
        (let _lp157334_ ((_rest157336_ (gxc#current-compile-gsc-options))
                         (_opts157337_ '()))
          (let* ((_rest157338157358_ _rest157336_)
                 (_else157342157366_ (lambda () _opts157337_)))
            (let ((_K157352157409_
                   (lambda (_rest157407_)
                     (let ()
                       (declare (not safe))
                       (_lp157334_ _rest157407_ _opts157337_))))
                  (_K157347157387_
                   (lambda (_rest157384_ _opt157385_)
                     (let ((__tmp158864
                            (append _opts157337_
                                    (filter gxc#not-string-empty?
                                            (let ()
                                              (declare (not safe))
                                              (string-split
                                               _opt157385_
                                               '#\space))))))
                       (declare (not safe))
                       (_lp157334_ _rest157384_ __tmp158864))))
                  (_K157344157372_
                   (lambda (_rest157370_)
                     (let ()
                       (declare (not safe))
                       (_lp157334_ _rest157370_ _opts157337_)))))
              (if (let () (declare (not safe)) (##pair? _rest157338157358_))
                  (let ((_tl157354157414_
                         (let ()
                           (declare (not safe))
                           (##cdr _rest157338157358_)))
                        (_hd157353157412_
                         (let ()
                           (declare (not safe))
                           (##car _rest157338157358_))))
                    (if (let ()
                          (declare (not safe))
                          (equal? _hd157353157412_ '"-cc-options"))
                        (if (let ()
                              (declare (not safe))
                              (##pair? _tl157354157414_))
                            (let* ((_tl157356157417_
                                    (let ()
                                      (declare (not safe))
                                      (##cdr _tl157354157414_)))
                                   (_rest157420_ _tl157356157417_))
                              (declare (not safe))
                              (_K157352157409_ _rest157420_))
                            (let ((_rest157378_ _tl157354157414_))
                              (declare (not safe))
                              (_K157344157372_ _rest157378_)))
                        (if (let ()
                              (declare (not safe))
                              (equal? _hd157353157412_ '"-ld-options"))
                            (if (let ()
                                  (declare (not safe))
                                  (##pair? _tl157354157414_))
                                (let ((_tl157351157397_
                                       (let ()
                                         (declare (not safe))
                                         (##cdr _tl157354157414_)))
                                      (_hd157350157395_
                                       (let ()
                                         (declare (not safe))
                                         (##car _tl157354157414_))))
                                  (let ((_opt157400_ _hd157350157395_)
                                        (_rest157402_ _tl157351157397_))
                                    (let ()
                                      (declare (not safe))
                                      (_K157347157387_
                                       _rest157402_
                                       _opt157400_))))
                                (let ((_rest157378_ _tl157354157414_))
                                  (declare (not safe))
                                  (_K157344157372_ _rest157378_)))
                            (let ((_rest157378_ _tl157354157414_))
                              (declare (not safe))
                              (_K157344157372_ _rest157378_)))))
                  (let () (declare (not safe)) (_else157342157366_))))))))
    (define gxc#not-string-empty?
      (lambda (_str157331_)
        (let ((__tmp158865
               (let () (declare (not safe)) (string-empty? _str157331_))))
          (declare (not safe))
          (not __tmp158865))))
    (define gxc#gsc-compile-file
      (lambda (_path157316_ _phi?157317_)
        (let* ((_gsc-link-opts157319_
                (let ()
                  (declare (not safe))
                  (gxc#gsc-link-options__% _phi?157317_)))
               (_gsc-cc-opts157321_
                (let ()
                  (declare (not safe))
                  (gxc#gsc-cc-options__% _phi?157317_)))
               (_gcc-ld-opts157323_
                (let () (declare (not safe)) (gxc#gcc-ld-options)))
               (_gsc-ld-opts157328_
                (let ((__tmp158866
                       (lambda (_opt157325_ _r157326_)
                         (let ((__tmp158867
                                (let ()
                                  (declare (not safe))
                                  (cons _opt157325_ _r157326_))))
                           (declare (not safe))
                           (cons '"-ld-options" __tmp158867)))))
                  (declare (not safe))
                  (foldr1 __tmp158866 '() _gcc-ld-opts157323_))))
          (let ((__tmp158871 (let () (declare (not safe)) (gxc#gerbil-gsc)))
                (__tmp158868
                 (let ((__tmp158869
                        (let ((__tmp158870
                               (let ()
                                 (declare (not safe))
                                 (cons _path157316_ '()))))
                          (declare (not safe))
                          (foldr1 cons __tmp158870 _gsc-ld-opts157328_))))
                   (declare (not safe))
                   (foldr1 cons __tmp158869 _gsc-cc-opts157321_))))
            (declare (not safe))
            (gxc#invoke __tmp158871 __tmp158868)))))
    (define gxc#compile-output-file
      (lambda (_ctx157287_ _n157288_ _ext157289_)
        (letrec ((_module-relative-path157291_
                  (lambda (_ctx157314_)
                    (path-strip-directory
                     (let ((__tmp158872
                            (##structure-ref
                             _ctx157314_
                             '1
                             gx#expander-context::t
                             '#f)))
                       (declare (not safe))
                       (gxc#module-id->path-string __tmp158872)))))
                 (_module-source-directory157292_
                  (lambda (_ctx157310_)
                    (path-directory
                     (let ((_mpath157312_
                            (##structure-ref
                             _ctx157310_
                             '7
                             gx#module-context::t
                             '#f)))
                       (if (let ()
                             (declare (not safe))
                             (string? _mpath157312_))
                           _mpath157312_
                           (last _mpath157312_))))))
                 (_section-string157293_
                  (lambda (_n157308_)
                    (if (let () (declare (not safe)) (number? _n157308_))
                        (number->string _n157308_)
                        (if (let () (declare (not safe)) (symbol? _n157308_))
                            (symbol->string _n157308_)
                            (if (let ()
                                  (declare (not safe))
                                  (string? _n157308_))
                                _n157308_
                                (let ()
                                  (declare (not safe))
                                  (gxc#raise-compile-error
                                   '"Unexpected section"
                                   _n157308_)))))))
                 (_file-name157294_
                  (lambda (_path157306_)
                    (if _n157288_
                        (string-append
                         _path157306_
                         '"--"
                         (let ()
                           (declare (not safe))
                           (_section-string157293_ _n157288_))
                         _ext157289_)
                        (string-append _path157306_ _ext157289_))))
                 (_file-path157295_
                  (lambda ()
                    (let ((_$e157301_ (gxc#current-compile-output-dir)))
                      (if _$e157301_
                          ((lambda (_outdir157304_)
                             (path-expand
                              (let ((__tmp158874
                                     (let ((__tmp158875
                                            (##structure-ref
                                             _ctx157287_
                                             '1
                                             gx#expander-context::t
                                             '#f)))
                                       (declare (not safe))
                                       (gxc#module-id->path-string
                                        __tmp158875))))
                                (declare (not safe))
                                (_file-name157294_ __tmp158874))
                              _outdir157304_))
                           _$e157301_)
                          (path-expand
                           (let ((__tmp158873
                                  (let ()
                                    (declare (not safe))
                                    (_module-relative-path157291_
                                     _ctx157287_))))
                             (declare (not safe))
                             (_file-name157294_ __tmp158873))
                           (let ()
                             (declare (not safe))
                             (_module-source-directory157292_
                              _ctx157287_))))))))
          (let ((_path157297_
                 (let () (declare (not safe)) (_file-path157295_))))
            (let ((__tmp158876
                   (lambda ()
                     (let ((__tmp158877 (path-directory _path157297_)))
                       (declare (not safe))
                       (create-directory*__0 __tmp158877)))))
              (declare (not safe))
              (with-lock gxc#+driver-mutex+ __tmp158876))
            _path157297_))))
    (define gxc#compile-static-output-file
      (lambda (_ctx157269_)
        (letrec ((_file-name157271_
                  (lambda (_id157285_)
                    (string-append
                     (let ()
                       (declare (not safe))
                       (gxc#static-module-name _id157285_))
                     '".scm")))
                 (_file-path157272_
                  (lambda ()
                    (let* ((_file157278_
                            (let ((__tmp158878
                                   (##structure-ref
                                    _ctx157269_
                                    '1
                                    gx#expander-context::t
                                    '#f)))
                              (declare (not safe))
                              (_file-name157271_ __tmp158878)))
                           (_$e157280_ (gxc#current-compile-output-dir)))
                      (if _$e157280_
                          ((lambda (_outdir157283_)
                             (path-expand
                              _file157278_
                              (path-expand '"static" _outdir157283_)))
                           _$e157280_)
                          (path-expand _file157278_ '"static"))))))
          (let ((_path157274_
                 (let () (declare (not safe)) (_file-path157272_))))
            (let ((__tmp158879
                   (lambda ()
                     (let ((__tmp158880 (path-directory _path157274_)))
                       (declare (not safe))
                       (create-directory*__0 __tmp158880)))))
              (declare (not safe))
              (with-lock gxc#+driver-mutex+ __tmp158879))
            _path157274_))))
    (define gxc#compile-exe-output-file
      (lambda (_ctx157263_ _opts157264_)
        (let ((_$e157266_
               (let ()
                 (declare (not safe))
                 (pgetq__0 'output-file: _opts157264_))))
          (if _$e157266_
              (values _$e157266_)
              (path-strip-directory
               (symbol->string
                (##structure-ref
                 _ctx157263_
                 '1
                 gx#expander-context::t
                 '#f)))))))
    (define gxc#static-module-name
      (lambda (_idstr157256_)
        (if (let () (declare (not safe)) (string? _idstr157256_))
            (let* ((_str157258_
                    (let ()
                      (declare (not safe))
                      (gxc#module-id->path-string _idstr157256_)))
                   (_strs157260_
                    (let ()
                      (declare (not safe))
                      (string-split _str157258_ '#\/))))
              (let () (declare (not safe)) (string-join _strs157260_ '"__")))
            (if (let () (declare (not safe)) (symbol? _idstr157256_))
                (let ((__tmp158881 (symbol->string _idstr157256_)))
                  (declare (not safe))
                  (gxc#static-module-name __tmp158881))
                (let ()
                  (declare (not safe))
                  (error '"Bad module id" _idstr157256_))))))
    (define gxc#invoke__%
      (lambda (_g158882_
               _stdout-redirection157217157221_
               _stderr-redirection157218157223_
               _program157225_
               _args157226_)
        (let* ((_stdout-redirection157228_
                (if (let ()
                      (declare (not safe))
                      (eq? _stdout-redirection157217157221_ absent-value))
                    '#f
                    _stdout-redirection157217157221_))
               (_stderr-redirection157230_
                (if (let ()
                      (declare (not safe))
                      (eq? _stderr-redirection157218157223_ absent-value))
                    '#f
                    _stderr-redirection157218157223_)))
          (let ((__tmp158883
                 (let ()
                   (declare (not safe))
                   (cons _program157225_ _args157226_))))
            (declare (not safe))
            (gxc#verbose '"invoke " __tmp158883))
          (let* ((_proc157232_
                  (open-process
                   (let ((__tmp158884
                          (let ((__tmp158885
                                 (let ((__tmp158886
                                        (let ((__tmp158887
                                               (let ((__tmp158888
                                                      (let ((__tmp158889
                                                             (let ((__tmp158890
;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                            (let ()
                              (declare (not safe))
                              (cons _stderr-redirection157230_ '()))))
                       (declare (not safe))
                       (cons 'stderr-redirection: __tmp158890))))
                (declare (not safe))
                (cons _stdout-redirection157228_ __tmp158889))))
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                 (declare (not safe))
                                                 (cons 'stdout-redirection:
                                                       __tmp158888))))
                                          (declare (not safe))
                                          (cons _args157226_ __tmp158887))))
                                   (declare (not safe))
                                   (cons 'arguments: __tmp158886))))
                            (declare (not safe))
                            (cons _program157225_ __tmp158885))))
                     (declare (not safe))
                     (cons 'path: __tmp158884))))
                 (_output157237_
                  (if (or _stdout-redirection157228_
                          _stderr-redirection157230_)
                      (read-line _proc157232_ '#f)
                      '#f)))
            (let ((_status157240_ (process-status _proc157232_)))
              (close-port _proc157232_)
              (if (let () (declare (not safe)) (zero? _status157240_))
                  '#!void
                  (begin
                    (display _output157237_)
                    (let ((__tmp158891
                           (let ()
                             (declare (not safe))
                             (cons _program157225_ _args157226_))))
                      (declare (not safe))
                      (gxc#raise-compile-error
                       '"Compilation error; process exit with nonzero status"
                       __tmp158891
                       _status157240_)))))))))
    (define gxc#invoke__@
      (lambda (_keys157216157245_ . _args157247_)
        (apply gxc#invoke__%
               _keys157216157245_
               (let ()
                 (declare (not safe))
                 (symbolic-table-ref
                  _keys157216157245_
                  'stdout-redirection:
                  absent-value))
               (let ()
                 (declare (not safe))
                 (symbolic-table-ref
                  _keys157216157245_
                  'stderr-redirection:
                  absent-value))
               _args157247_)))
    (define gxc#invoke
      (lambda _args157219157253_
        (apply keyword-dispatch
               '#(stderr-redirection: stdout-redirection:)
               gxc#invoke__@
               _args157219157253_)))
    (define gxc#join!
      (lambda (_thread157210_)
        (let ((__tmp158893
               (lambda (_exn157212_)
                 (if (let ()
                       (declare (not safe))
                       (uncaught-exception? _exn157212_))
                     (let ((__tmp158894
                            (let ()
                              (declare (not safe))
                              (uncaught-exception-reason _exn157212_))))
                       (declare (not safe))
                       (raise __tmp158894))
                     (let () (declare (not safe)) (raise _exn157212_)))))
              (__tmp158892 (lambda () (thread-join! _thread157210_))))
          (declare (not safe))
          (with-catch __tmp158893 __tmp158892))))))
