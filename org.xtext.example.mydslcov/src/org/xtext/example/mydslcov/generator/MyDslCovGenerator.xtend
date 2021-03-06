/*
 * generated by Xtext 2.25.0
 */
package org.xtext.example.mydslcov.generator

import com.google.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtend2.lib.StringConcatenationClient
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.xtext.generator.trace.node.Traced
import org.eclipse.xtext.generator.trace.node.TracedAccessors
import org.xtext.example.mydslcov.myDslCov.Greeting
import org.xtext.example.mydslcov.myDslCov.Model
import org.xtext.example.mydslcov.myDslCov.MyDslCovFactory

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MyDslCovGenerator extends AbstractGenerator {

	@TracedAccessors(MyDslCovFactory)
	static class MyDslTraceExtensions {
	}
	
	@Inject
	extension MyDslTraceExtensions

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		
		for (model : resource.allContents.filter(Model).toIterable) {
			val name = resource.URI.trimFileExtension.lastSegment
			fsa.generateTracedFile("demo/Greeter_"+name+".java",model, '''
			package demo;
			
			public class Greeter_«name» {
			    public static void main(String[] args) {
			        «FOR g : model.greetings»
			            System.out.println("«g._name(true)»");
«««			            if (Math.random()<0.2) return;
			        «ENDFOR»
			    }
			}
			''')
			
			
			
//			fsa.generateTracedFile("demo/Greeter_"+name+"2.java",model, '''
//			package demo;
//			
//			public class Greeter_«name»2 {
//			    public static void doit() {
//			      «FOR g : model.greetings»
//			            «g.compile»
//			      «ENDFOR»
//			    }
//			}
//			''')
		}
		
		
		for (g : resource.allContents.filter(Greeting).toIterable) {
			
		}
	}
	
	@Traced(useForDebugging=true)
	def StringConcatenationClient compile(Greeting g) '''
		System.out.println("«g.name»");
	'''
}
